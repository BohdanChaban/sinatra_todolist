# Sinatra To Do List API

Simple To Do List API to manage your lists and tasks.

## API resources:

`/lists` - show lists, add new and delete exists

`/tasks` - show tasks, add new and delete exists

`/refresh` - clean the database and create the initial data

## Setup

```
bundle install

rake db:setup
```

## Run

```
rackup config.ru
```
or

```
rackup
```
Default host for development: `localhost:9292`

### Application example

[Heroku](https://todolist-api-sinatra.herokuapp.com/)
