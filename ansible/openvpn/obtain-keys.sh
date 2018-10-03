#!/bin/bash

# Output how to use the script
function help {
    printf "
This script will obtain OpenVPN keys for a client

Usage:
    ./obtain-keys.sh -i SSH_PRIVATE_KEY -s USER@SERVER -c VPN_CLIENT
    -i  Private ssh key
    -s  Linux sudo user and server
    -c  OpenVPN client
";
}

# Get parameters
while getopts i:s:c: option; do
    case "${option}" in
        i) SSH_KEY=${OPTARG};;
        s) LOGIN=${OPTARG};;
        c) VPN_CLIENT=${OPTARG};;
    esac
done

# Check required parameter exist
if [ -z ${SSH_KEY} ] || [ -z ${LOGIN} ] || [ -z ${VPN_CLIENT} ]; then
    help
    exit
fi

ssh -i ${SSH_KEY} ${LOGIN} "sudo cp /etc/openvpn/easy-rsa/keys/${VPN_CLIENT}.tar.gz . && sudo chmod 666 ${VPN_CLIENT}.tar.gz"
scp -i ${SSH_KEY} ${LOGIN}:${VPN_CLIENT}.tar.gz .
ssh -i ${SSH_KEY} ${LOGIN} "rm ${VPN_CLIENT}.tar.gz"
