require 'sinatra'
require 'sinatra/reloader'
also_reload 'lib/**/*.rb'
require './lib/project'
require './lib/volunteer'
require 'pry'
require 'pg'

DB = PG.connect({:dbname => "volunteer_tracker"})

get '/' do
  erb :main
end

get '/test' do
  binding.pry
  erb :main
end

post '/' do
  title = params.fetch('title')
  project = Project.new({title: title, id: nil})
  project.save
  @projects = Project.all
  erb :main
end

get '/projects' do
  @projects = Project.all

  erb :projects
end

get '/projects/:id' do
  @project = Project.find(params.fetch('id').to_i)
  erb :project
end

post '/projects' do
  title = params.fetch('title')
  project = Project.new({title: title, id: nil})
  project.save
  @projects = Project.all
  erb :projects
end

post '/projects/:id' do
  name = params.fetch('name')
  id = params.fetch('id').to_i
  volunteer = Volunteer.new({name: name, project_id: id, id: nil})
  volunteer.save
  @projects = Project.all
  redirect '/projects'
end

get '/projects/:id/edit' do
  @project = Project.find(params.fetch('id').to_i)
  erb :edit
end

post '/projects/:id/edit' do
  @project = Project.find(params.fetch(:id).to_i)
  title = params.fetch('title')
  @project.update({title: title})
  redirect '/projects'
end

delete('/projects/:id') do
  project = Project.find(params.fetch(:id).to_i)
  project.delete
  redirect '/projects'
end

delete('/volunteers/:id') do
  volunteer = Volunteer.find(params.fetch(:id).to_i)
  volunteer.delete
  redirect '/projects'
end

get '/volunteers/:id' do
  @volunteer = Volunteer.find(params.fetch('id').to_i)
  erb :volunteer
end
