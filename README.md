# BookRecorder

## Prepare
1 Clone this repository  
2 [Install Docker](https://docs.docker.com/engine/installation/)  
3 Make Directory

```
$ mkdir tmp/mysql
$ mkdir tmp/share
```  
4 Start docker  

```
$ docker-compose build
$ docker-compose up -d
```
5 Setup Database

```
$ docker-compose run web rake db:create
$ docker-compose run web rake db:migrate
```
6 Access  
[http://localhost](http://localhost)

## Stop Docker

```
$ docker-compose stop
```