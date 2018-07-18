require 'sinatra'
require 'sinatra/cross_origin'
require 'sinatra/activerecord'
require './config/environments'
require './config/cors'
require './models/list'
require './models/task'
require 'json'

before do
  content_type :json
end

get '/lists' do
  List.all.to_json(include: :tasks)
end

get '/lists/:id' do
  List.find(params['id']).to_json(include: :tasks)
end

post '/lists' do
  list = List.new(params)

  if list.save
    list.to_json(include: :tasks)
  else
    halt 422, list.errors.full_messages.to_json
  end
end

put '/lists/:id' do
  list = List.find(params['id'])

  if list
    list.name = params.fetch('name', nil)
    list.color = params.fetch('color', nil)

    if list.save
      list.to_json
    else
      halt 422, list.errors.full_messages.to_json
    end
  end
end

delete '/lists/:id' do
  list = List.find(params['id'])

  if list.destroy_all
    {success: 'ok'}.to_json
  else
    halt 500
  end
end

get '/tasks' do
  Task.all.to_json
end

get '/tasks/:id' do
  Task.find(params['id']).to_json
end

post '/tasks' do
  task = Task.new(params)

  if task.save
    task.to_json
  else
    halt 422, task.errors.full_messages.to_json
  end
end

put '/tasks/:id' do
  task = Task.find(params['id'])

  if task
    task.name = params.fetch('name', nil)

    if task.save
      task.to_json
    else
      halt 422, task.errors.full_messages.to_json
    end
  end
end

delete '/tasks/:id' do
  task = Task.find(params['id'])

  if task.destroy_all
    {success: 'ok'}.to_json
  else
    halt 500
  end
end


get '/' do
  content_type :html
  send_file './public/index.html'
end

get '/refresh' do
  # Clean the database and create the initial data
  load './db/seeds.rb'
end
