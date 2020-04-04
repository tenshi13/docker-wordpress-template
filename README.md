# Docker Wordpress Template
A boilerplate for local docker wordpress development setup<br />
NOTE: Not production ready<br />
Includes:
* docker for devops
* apache php for wordpress
* mysql for database
* nginx for docker proxy

structure:
```
/repo
    /mysql
        /data    -> placeholder folder to store backup sqls
        /db      -> actual folder where mysql db files will live
        /dbstart -> place to put wordpress db startup sqls

    /devops
        /docker
            /db
                /mysql   -> ../../../mysql/db
                /dbstart -> ../../../mysql/dbstart
            /web
                /apache     -> any apache specific configs?
                /php        -> any php specific configs?
                /phpmyadmin -> ../../../phpmyadmin
                /wordpress  -> ../../../wordpress
            /proxy
                /nginx     -> any config for nginx?

    /phpmyadmin -> TODO: want to add phpmyadmin to this project

    /wordpress -> actual folder where wordpress code will live

    /tools -> scripts to manage the project
        /db     -> scripts related to db operations
        /vendor -> 3rd party libraries
```

## Nginx for internal proxy
* In docker there's internal and external networking,
* this makes it complicated to wire up the .local domains we're developing on
* we're using a local nginx as reverse proxy to reroute all dev domains to internal docker ips

## Kickstarting a new WP site
clone project into website folder
```
git clone git@github.com:tenshi13/docker-wordpress-template.git site_domain.tld
```
remove the .git folder and redo git init
```
rm -rf .git
```
re-add a remote repo
```
git remote add origin repo_url
```
the first docker up run will generate/copy the wordpress's core files into the /source folder
add everything and commit it, then push it as the initial commit/PR

## Usage
* We will need to generate the .env file will required docker variables in docker-compose.yml first, see .env.sample
* and then add the local domain in the host's /etc/hosts and refresh the host dns
* should be able to do it by just adding '127.0.0.1    domain.local' (our proxy container will resolve this)
* then we can start the docker containers and run the wp environment locally
* at the /devops/docker/ folder
```
docker-compose -f docker-compose.yml up
```
* once it settles you should be able to browse to your_site.local
* just modify the codes in /source folder to update your wordpress code

# Credits/References
* https://github.com/jwilder/nginx-proxy
  the nginx proxy's author repo, awesome work that made life heaps easier
* https://hub.docker.com/_/mysql
* https://hub.docker.com/_/wordpress/

# TODO:
Problem with docker-wordpress-template
- Issue : We can use localhost with port forwarding but this is annoying when juggling multiple projects
- Found traefik - and edge reverse proxy, we can forward to local domain, instead of port
- Issue:  then .dev and local ssl cert
- Found mkcert, need to bake it into part of the Init/setup script

## Mkcert
see: 
- https://geekflare.com/local-dev-environment-ssl/
https://www.freecodecamp.org/news/how-to-get-valid-ssl-certificates-for-local-development-ca228240fad2/ - simpler

Mkcert needs to issue the root cert, install it
Then use it to generate a cert for the local site
Place it somewhere, and we need to config the servers where to find that cert when it starts the server

## Traefik
see:
- https://hollo.me/devops/routing-to-multiple-docker-compose-development-setups-with-traefik.html
After generating the certs, we can add them to the label of traffic

Now we can wrap mkcert and traefik in each individual project independantly

### TODO tasks:
- Create mkcert docker image, avoid multi platform dev issues
- Update docker-wordpress-template
