FROM nginx:latest

RUN rm  /etc/nginx/conf.d/default.conf

RUN mkdir /etc/nginx/conf-available

COPY assets/entrypoint.sh /entrypoint.sh
COPY assets/site-ssl-redirect.template  /etc/nginx/templates/site-ssl-redirect.template
COPY assets/site-no-ssl.template  /etc/nginx/templates/site-no-ssl.template
COPY assets/site-ssl.template  /etc/nginx/templates/site-ssl.template

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
