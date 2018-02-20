# BookRecorder

## Prepare
1 Clone this repository  
2 [Install Docker](https://docs.docker.com/engine/installation/)  
3 Start docker  

```
$ docker-compose build
$ docker-compose up -d
```
4 Setup Database

```
$ docker-compose run web rake db:create
$ docker-compose run web rake db:migrate
```
5 Access  
[http://localhost:3000](http://localhost:3000)

## Stop Docker

```
$ docker-compose stop
```