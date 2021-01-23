#!/bin/bash
############################################
#
#   FOR NOW JUST FOR UBUNTU :(
#
###########################################

VERSION='1.0.0'
#BUILD='Gen 22 2020 16:39:55'
function version_info()
{
    echo ""
    echo "VH  $VERSION (cli)"
    echo ""
}

function usage()
{
    cat << "EOF"
     _                                  _                         
  __| | _   _  _ __    __ _  _ __ ___  (_)  ___   /\   /\   /\  /\
 / _` || | | || '_ \  / _` || '_ ` _ \ | | / __|  \ \ / /  / /_/ /
| (_| || |_| || | | || (_| || | | | | || || (__    \ V /  / __  / 
 \__,_| \__, ||_| |_| \__,_||_| |_| |_||_| \___|    \_/   \/ /_/  
        |___/                                                     

                                                    Powered by Alfonso with ❤ 
    

    Usage: vh [options] [args...]

    -s               Start program
    -l               List sites enabled
    -v               Version number
    -h               This help



EOF
}


function writeVHconf()
{
    
    APACHE_LOG_DIR='/var/log/apache2'

    echo "<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        ServerName ${SERVER_NAME}
        ServerAlias ${SERVER_ALIAS}
        ServerAdmin ${SERVER_EMAIL}
        DocumentRoot ${DOC_ROOT}

        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/${ERROR_LOG}.log
        CustomLog ${APACHE_LOG_DIR}/${CUSTOM_LOG}.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with \"a2disconf\".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>" >> /etc/apache2/sites-available/${VH_CONF}

}

listSites()
{
    echo ""
    a2query -s
    echo "" 
}

function main()
{
    echo "Enter VirtualHost name: "
    read VH_NAME
    VH_CONF="${VH_NAME}.conf"
    echo "Enter ServerName: (ex: www.example.com)"
    read SERVER_NAME
    echo "Enter ServerAlias: (ex: example.local)"
    read SERVER_ALIAS
    echo "Enter DocumentRoot:"
    read DOC_ROOT
    echo "Enter ServerAdmin: (email)"
    read SERVER_EMAIL
    echo "Enter ErrorLog file name: "
    read ERROR_LOG
    echo "Enter CustomLog file name: "
    read CUSTOM_LOG
    echo "Enter IP Server: (ex: 127.0.0.1)"
    read IP_VH
    if [ $IP_VH -eq '']
        then IP_VH='127.0.0.1'
    fi
    echo $IP_VH
    #touch /etc/apache2/sites-available/$VH_CONF
    writeVHconf
    
    touch /etc/hosts_orig
    cat /etc/hosts >> /etc/hosts_orig 
    echo "${IP_VH}                      ${SERVER_ALIAS}" > /etc/hosts
    cat /etc/hosts_orig >> /etc/hosts
    rm /etc/hosts_orig

    a2ensite ${VH_CONF} 
    
    systemctl restart apache2

}

#echo "You start with $# positional parameters"
if [ $# -eq 0 ] 
then
    usage
    exit 1
fi

# Loop until all parameters are used up
while [ "$1" != "" ]; do
    #echo "Parameter 1 equals $1"
    #echo "You now have $# positional parameters"
    case $1 in 
        -s )                
            shift
            main
            ;;
        -v | --version )    
            shift
            version_info
            ;;
        -h  | --help )
            shift
            usage
            exit
            ;;
        -l )
            listSites
            exit
            ;;
        * )                 
            usage
            exit 1
    esac
    shift
done

