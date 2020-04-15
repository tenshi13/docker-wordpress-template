# Docker Wordpress Template
A boilerplate for local docker wordpress local development<br />
NOTE: This is for local dev and not production ready/tested<br />
Included components:
- traefik - edge router for local domain proxy to avoid docker port dancing
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
    - `LOCAL_DOMAIN.localhost` - the one you set in .env, should display the wp site
    - `pma.LOCAL_DOMAIN.localhost` - should display the phpmysqladmin web console
- working with existing sites locally, see setup below

## Setup
### Mysql Database
- download a copy of the database .sql export from your live wp site
  - you can do this via `mysqldump` if you have ssh admin access, or
    ```
    mysqldump -u root -pROOT_PASSWORD -h localhost DB_NAME | gzip > DB_NAME.sql.gz
    ```
  - if you have the `phpmysqladmin` web console on your live website
- the live export .sql should be saved into the `/data_in` folder
- see the script in /tools/data_in.sh, this script helps replace the `LIVE_DOMAIN` in the .sql in the data_in folder with the `LOCAL_DOMAIN` set in the `/docker/.env` file
- visit `pma.LOCAL_DOMAIN.localhost` and import the prepared `_in.sql` file to the correct local wp `MYSQL_DATABASE`

### Wordpress Themes/Customizations
- there are 2 folders in `/wordpress/wp-content` - plugins and themes
- you can zip and copy those folders from your live site and replace them locally to install plugins or themes
- once you've replace the local folders, make sure you login to your local wp admin to actite the plugins or select the right theme again
- if you have any manual customizations to other wordpress files, you will have to replace and test them manually

## References
* https://docs.traefik.io/user-guides/docker-compose/basic-example/
* https://hub.docker.com/_/mysql
* https://hub.docker.com/_/wordpress/
* https://hub.docker.com/r/phpmyadmin/phpmyadmin/

## TODO:
- spliting of traefik service so we can work with multiple `docker-wordpress-template` sites/copies locally
- try enable SSL/HTTPS by integrating mkcert:
- integrate mailhog for local mail testing

### Mkcert
see: 
- https://geekflare.com/local-dev-environment-ssl/
https://www.freecodecamp.org/news/how-to-get-valid-ssl-certificates-for-local-development-ca228240fad2/ - simpler

Mkcert needs to issue the root cert, install it
Then use it to generate a cert for the local site
Place it somewhere, and we need to config the servers where to find that cert when it starts the server