#!/usr/bin/env bash

set -e

[ -z "${FCGI_PASS}" ] && echo "Need to set FCGI_PASS" && exit 1;
[ -z "${FCGI_FRONT_CONTROLLER}" ] && echo "Need to set FCGI_FRONT_CONTROLLER" && exit 1;

if [[ ! -z "${SSL_CERT}" ]]; then
    [ -z "${SSL_KEY}" ] && echo "Need to set SSL_KEY" && exit 1;
    echo "Generating certificate files..."
    mkdir -p /etc/nginx/certs
    echo ${SSL_CERT} > /etc/nginx/certs/cert.crt
    echo ${SSL_KEY} > /etc/nginx/certs/key.key
    envsubst '${FCGI_PASS} ${FCGI_FRONT_CONTROLLER} ${WEB_ROOT}' < /etc/nginx/templates/site-ssl.template > /etc/nginx/conf.d/site-ssl.conf
    if [[ -z "${SSL_REDIRECT}" ]]; then
        echo "SSL redirection configured. HTTP requests will be redirected to HTTPS."
        envsubst '${FCGI_PASS} ${FCGI_FRONT_CONTROLLER} ${WEB_ROOT}' < /etc/nginx/templates/site-ssl-redirect.template > /etc/nginx/conf.d/site-ssl-redirect.conf
    else
        echo "SSL redirection not configured. The site will be available via HTTP and HTTPS."
        envsubst '${FCGI_PASS} ${FCGI_FRONT_CONTROLLER} ${WEB_ROOT}' < /etc/nginx/templates/site-no-ssl.template > /etc/nginx/conf.d/site-no-ssl.conf
    fi
else
    echo "SSL_CERT undefined. Serving HTTP only..."
    envsubst '${FCGI_PASS} ${FCGI_FRONT_CONTROLLER} ${WEB_ROOT}' < /etc/nginx/templates/site-no-ssl.template > /etc/nginx/conf.d/site-no-ssl.conf
fi

exec "$@"