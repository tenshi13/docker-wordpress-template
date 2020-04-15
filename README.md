# Docker Wordpress Template
A boilerplate for local docker wordpress local development<br />
NOTE: Not production ready<br />
Included components
- traefik - edge router for local domain proxy to avoide docker port dancing
- wordpress - our target cms
- mysql - our target db
- phpmysqladmin - db web management

## Folder Structure
```
/data_in
    - empty folder
    - put the .sql dump generate from the live site here
/data_out
    - empty folder
    - output the phpmysqladmin export of the local site here
/docker
    - where the docker-compose.yml and .env lives, there is a .env.sample template also
/mysql
    - volume folder for mysql dbdata lives
/tools
    - tools folder
    - data_in.sh - takes a filename to search for in the /data_in folder,
                   replaces the live domain with the local domain set in the /docker/.env
    - data_out.sh - takes a filename to search for in the /data_out folder,
                    replaces the local domain with the live domain set in the /docker/.env
/wordpress
    - volume folder for the wordpress docker to copy and drop the wordpress php scripts
```

## Usage
- copy /docker/.env.sample as /docker/.env
- have a look at the entries and replace for your project accordingly
- create a docker bridge network called `traefik_net` if you have not yet
    ```
    docker network create traefik_net
    ```
- start the stack in the /docker folder:
    ```
    docker-compose up
    ```
- once everything is loaded, try to visit:
    - `localhost:8080` - the traefik edge router's web console
    - `local_url.localhost` - the one you set in .env, should display the wp site
    - `pma.local_url.localhost` - should display the phpmysqladmin web console

## References
* https://docs.traefik.io/user-guides/docker-compose/basic-example/
* https://hub.docker.com/_/mysql
* https://hub.docker.com/_/wordpress/
* https://hub.docker.com/r/phpmyadmin/phpmyadmin/

## TODO:
- try enable SSL/HTTPS by integrating mkcert:
- integrate mailhog for local mail testing

### Mkcert
see: 
- https://geekflare.com/local-dev-environment-ssl/
https://www.freecodecamp.org/news/how-to-get-valid-ssl-certificates-for-local-development-ca228240fad2/ - simpler

Mkcert needs to issue the root cert, install it
Then use it to generate a cert for the local site
Place it somewhere, and we need to config the servers where to find that cert when it starts the server