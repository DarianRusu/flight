#!/bin/sh

ARGS=5
mlcp_location=""
host=""
port=""
username=""
password=""



if [ $# -lt "$ARGS" ]
then
        echo "Usage: ./load.sh -mlcp {location for mlcp.sh} -host {host} -port {port} -username {username} -password {password}"
        exit 1
fi

while [ "$1" != "" ];do
    case $1 in
        -mlcp)          shift
                    mlcp_location=$1
                    ;;
        -host)			    shift
                    host=$1
                    ;;
        -port)			    shift
                    port=$1
                    ;;
        -username)		  shift
                    username=$1
                    ;;
        -password)      shift
                    password=$1
                    ;;
        *)
    esac
    shift
done;

sh -c "$mlcp_location/mlcp.sh import -host $host -port $port -username $username -password $password -input_file_path ./carriers -input_file_type delimited_text -generate_uri true -output_collections carriers -delimited_root_name carrier" sh
sh -c "$mlcp_location/mlcp.sh import -host $host -port $port -username $username -password $password -input_file_path ./airlines -input_file_type delimited_text -generate_uri true -output_collections airlines -delimited_root_name airline" sh
sh -c "$mlcp_location/mlcp.sh import -host $host -port $port -username $username -password $password -input_file_path ./flights -input_file_type delimited_text -generate_uri true -output_collections flights -delimited_root_name flight" sh


