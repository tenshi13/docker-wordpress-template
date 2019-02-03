# Docker Wordpress Template
a boilerplate for my docker wordpress development setup
includes:
* docker for devops
* apache php for wordpress
* mysql for database
* nginx for docker proxy

structure:
```
/repo
    /db
    /devops
        /docker
            /db
                /bin     -> dirty ETL scripts
                /mysql   -> ../../../db (actual db files)
                /data    -> folder used to store backedup data, later processed by scripts in bin to load into local db
                /dbstart -> any mysql startup script? maybe to use in the begining
            /web
                /apache    -> any apache specific configs?
                /php       -> any php specific configs?
                /wordpress -> ../../../source (actual source)
            /proxy
                /nginx     -> any config for nginx?

    /source
```

## Nginx for internal proxy
* In docker there's internal and external networking,
* this makes it complicated to wire up the .local domains we're developing on
* we're using a local nginx as reverse proxy to reroute all dev domains to internal docker ips

## Usage
* We will need to generate the .env file will required docker variables in docker-compose.yml first
* and then add the local domain in the host's /etc/hosts and refresh the host dns
* should be able to do it by just adding '127.0.0.1    domain.local' (our proxy container will resolve this)
* then we can start the docker containers and run the wp environment locally

# Credits/References
* https://github.com/jwilder/nginx-proxy
  the nginx proxy's author repo, awesome work that made life heaps easier
* https://hub.docker.com/_/mysql
* https://hub.docker.com/_/wordpress/
