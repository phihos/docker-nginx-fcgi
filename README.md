# Docker Nginx web server for PHP-FPM

Configurable Nginx frontend for PHP-FPM.

## Environment

| Name                  | Description                                                                                                              |
|-----------------------|--------------------------------------------------------------------------------------------------------------------------|
| WEB_ROOT              | Web root for the virtual host. Mount a volume with static files here. Must be the same path as in the PHP-FPM container. |
| FCGI_PASS             | Value for the "fcgi_pass" directive. Example: php-fpm:9000.                                                              |
| FCGI_FRONT_CONTROLLER |  Name of the PHP front controller without the .php extension. For Symfony use "app" or "app_dev" for the dev environment.|

