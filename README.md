# BookRecorder

## Prepare
1 Clone this repository  
2 [Install Docker](https://docs.docker.com/engine/installation/)  
3 Create your "database.yml"  

```yml
default: &default
  adapter: mysql2
  encoding: utf8
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: root
  password: root
  host: db

development:
  <<: *default
  database: book_recorder_development

test:
  <<: *default
  database: book_recorder_test
```
4 Start docker

```
$ docker-compose build
$ docker-compose up -d
```
5 Setup Database

```
$ docker-compose run ruby rake db:create
$ docker-compose run ruby rake db:migrate
```
6 Access  
[http://localhost:3000](http://localhost:3000)

## Stop Docker

```
$ docker-compose stop
```