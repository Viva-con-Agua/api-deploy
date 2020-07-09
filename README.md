# api-deploy
scripts for deploy api services

## Initial

You can create create a file named `.env` in the root directory like:
```
    branche="develop"
    editor="something less cooler than nvim"
```
Default branche is set to `develop` and editor to `nvim`. 

## Workflow


### Install
All repositories are stored in the `repos` directory. New repositories can be added with the `./please install <backend-name> <apiVersion>`.
The different api versions can then be accessed with `/v1/` `/v2/` etc in the url. So pay attention to the context path of your serivces.
We only provide branche from the Viva-con-Agua git repository and will match the `<backend-name>` with an existing branch.

After the branch was downloaded the script will copy the `config` directory of your repository into the global config folder.
Each service have a directory like `config/<backend-name>`. 

Now the script open all relevant files with your default editor.

```
 docker-compose.yml            # see setup api with compose
 location.<apiVersion>         # nginx route
 default.upstream              # for reverse Proxy
 config.yml                    # backend config
~~ database.env                # the script now from docker-compose.yml if you need a database
```

### docker-compose.yml

Setup simple service for api in `docker-compose.yml`. Store it at the end of the file and use the next ipv4_address in row.
```
    plain-backend:
        image: vivaconagua/plain-backend:latest
        build: ./repos/auth-backend
        container_name: auth-backend
        restart: unless-stopped
        volumes:
            - ./config/plain-backend/config.yml:/go/src/plain-backend/config/config.yml
        networks:
            default:
                ipv4_address: 172.2.60-79.xxx
```

In case you need a database for your service define it like:

```
    plain-backend-db:
        image: mysql
        container_name: plain-db
        restart: unless-stopped
        env_file: ./config/auth-backend/database.env
        volumes:
            - ./volumes/plain-backend-db/mysql/:/var/lib/mysql/
            - ./repos/plain-backend/config/db/:/docker-entrypoint-initdb.d/
        networks:
            default:
                ipv4_address: 172.2.80-99.xxx  

```

The dumps will stored in volumes directory. We use mysql based databases, so we can easy use entrypoint-initdb.d folder for 
database evolutions. Your evolutions files should look like `1.sql`, `2.sql` ... . 
Name you database like `<backend-name>-db`, so the script can finde the service.

### nginx

default.upstream:
```
upstream plain-backend {
    server 172.2.60.xxx:1323;
}
```
location.<apiVersion>:

```
location /<apiVersion>/<modelName> {
    proxy_pass http://plain-backend;
    proxy_http_version 1.1;
    proxy_set_header   Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_set_header   Host $host;
}
```
If your service provide more than one model over api, you can add multiple `location` with same `proxy_pass`. Same if your service get updated and provide new models you need to update the location file too.

### config.yml

Store the documentation in the Readme.md of the respective repository.


### setup docker

`./please setup <backend-name>` up all docker you need.

### update
`./please update <backend-name>` update the repository from git and setup only the backend-service. 
!! New routes? You can open the location.<apiVersion> file and edit it.
!! Database updates? It's to hot for do it with simple update. Use `docker-compose restart <database-name>` will install the evolution.
