#!/bin/bash
set -e

if [ "${AUTOCONFIG}" != "" ]; then

  if [ "${LOCAL_NET}" == "" ]; then
    export LOCAL_NET=$(ip addr | awk '/inet / { print $2 }' | paste -sd ',')
  fi

  if [ "${EXTERNAL_ADDRESS}" == "" ]; then
    case ${AUTOCONFIG} in
      rancher)
        export EXTERNAL_ADDRESS=$(curl -s 'http://rancher-metadata/latest/self/host/agent_ip')
        ;;

      aws)
        export EXTERNAL_ADDRESS=$(curl -s 'http://169.254.169.254/latest/meta-data/public-ipv4')
        ;;

      ifconfig.co)
        export EXTERNAL_ADDRESS=$(curl -s 'https://ifconfig.co/')
        ;;

      *)
        echo "Unknown AUTOCONFIG method for EXTERNAL_ADDRESS: ${AUTOCONFIG}"
        ;;
    esac
  fi

fi

exec ./asterisk-docker-entrypoint.sh "$@"
