#!/usr/bin/php
<?php

$start_t=date("d-m-Y H:i:s");   
$start=time();
$starttime=microtime(true);


if(php_sapi_name()!='cli')die('Could not execute');



function request($url,$method="GET",$params=array())
{
    $start_request= microtime(true);
    $baseurl="https://api/";
    $maxredirect=10;
    $req=array(
        "http"=>array(
            "method"          => $method,
            'ignore_errors'   => true,
            //follow_location => false,
            "header"          =>array(
                "Content-Type: application/json",
            ),
        )
    );

  if(strpos($url,"http://")!==0 && strpos($url,"https://")!==0) $url=$baseurl.$url;
    if($params){
        $body=json_encode($params);
        $req['http']['content']=$body;
        $req['http']['header'][]='Content-Length: '.strlen($body);
    }
    $data=false;
    
do{
        //printf("\nURL:\t%s",$url);                  //
        if(($ctx=stream_context_create($req)))
        {
            //print("\nstram ctx: ".print_r($ctx,true));
            $code=false;
            if(($src=@fopen($url,'r',false,$ctx))) {
                $mt = stream_get_meta_data($src);
                //print("\n mt: ".print_r($mt,true));
                /*
                    -timed_out
                    -blocker
                    -eof
                    -wrapper_data
                    -wrapper_type
                    -stram_type
                    -mode
                    -unread_bytes
                    -seekable
                    -uri
                */
                foreach($mt['wrapper_data'] as $hdr){
                    //print("HDR: ".print_r($hdr,true));
                    if(preg_match('/^HTTP\/[0-9]\.[0-9] ([0-9][0-9][0-9]) (.*)/',$hdr,$m) && $code===false){
                        $code=$m[1];
                        $msg=$m[2];
                        //printf("\nCODE: %d\tMSG: %s",$code,$msg);
                        $hdrs=array();
                    }
                    else if(preg_match('/^([^:]+):(.*)/',$hdr,$m)){
                        $key=strtolower($m[1]);
                        $value=trim($m[2]);
                        
                        if(is_array($hdrs[$key])) $hdrs[$key][]=$value;
                        else if(!isset($hdrs[$key])) $hdrs[$key]=$value;
                        else $hdrs[$key]=array($hdrs[$key],$value);
                    }
                }
                print("\n hdrs: ".print_r($hdrs,true));
                if($code==307 || $code==301 || $code==302 || $code==404 || $code==502 ){
                    if(isset($hdrs['location'])){
                        $url= $hdrs['location'];
                        print("\nURL: ".print_r($url,true));
                        @fclose($src);
                        continue;
                    }
                }
                $middle_time=microtime(true);

 if($data=stream_get_contents($src,-1))
                {
                    //print("\ntype of ".gettype($data));
                    //print("\ndata: ".print_r($data,true));
                    
                    if($data=json_decode($data,true)){
                        @fclose($src);
                        break;
                    }
                    else{
                        //printf("\n*vuln*: DATA JSON FALSE\n");
                        /**
                         * 0 = JSON_ERROR_NONE
                         * 1 = JSON_ERROR_DEPTH
                         * 2 = JSON_ERROR_STATE_MISMATCH
                         * 3 = JSON_ERROR_CTRL_CHAR
                         * 4 = JSON_ERROR_SYNTAX
                         * 5 = JSON_ERROR_UTF8
                         * 6 = JSON_ERROR_RECURSION
                         * 7 = JSON_ERROR_INF_OR_NAN
                         * 8 = JSON_ERROR_UNSUPPORTED_TYPE
                         */
                        if(!function_exists('json_last_error_msg')){
                            $last_error=json_last_error();
                            if(is_numeric($last_error)){
                                switch($last_error){
                                    case '0':
                                        $error="JSON_ERROR_NONE";
                                        break;
                                    case '4':
                                        $error="JSON_ERROR_SYNTAX";
                                    default:
                                        $error="JSON ERROR";
                                        break;
                                }
                                ($last_error==0) ? printf("\nXXX: Empty result for %s\n",$url) : printf("\nXXX: JSON_ERROR: %s\tLast error: %d\n\tfor %s\n\n",$error,$last_error,$url);
                                @fclose($src);
                                return false;    
                            }
                            printf("\nXXX: JSON_ERROR\n*vuln*: Empty result for %s\n",$url);
                            
                            @fclose($src);
                            return false;
                        }
                        $error=json_last_error_msg();
                        $last_error=json_last_error();
                        ($last_error==0) ? printf("\nXXX: Empty result for %s\n",$url) : printf("\nXXX: JSON_ERROR: %s\tLast error: %d\n\tfor %s\n\n",$error,$last_error,$url);
                        
                        @fclose($src);
                        return false;    
                    }
                }
                else{
                    printf("\n*vuln*: DATA STREAM CONTENTS FALSE\n");
                    @fclose($src);
                    return false;
                }
            }
        }
        print("\nN°: ".$maxredirect."\n");
    }while((--$maxredirect>0));

    $end_request=microtime(true);

  return $data;    

?>
