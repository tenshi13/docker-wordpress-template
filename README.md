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
