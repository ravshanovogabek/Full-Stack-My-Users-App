require 'sinatra'
require_relative 'my_user_model.rb'
set:bind, '0.0.0.0' #set:bind means each user in the world can get an access of the our web site
set:port, '8080' #set:port means in this kind of the port our server would be work and especially for docode we should put this '8080' port
enable :sessions
#It will create a user and store in your database and returns the user created
post '/users' do
    user = User.new()
    user_info= [params['firstname'], params['lastname'], params['age'], params['password'], params['email']]
    id=user.create(user_info)
    "Successfully created a user with userId = #{id}"
end
#This action will return all users
get '/users' do 
    user = User.new()
    @users = user.all()
    erb :index
end 
#It will add a session containing the user_id in order to be logged in and returns the user created
post 'sign_in' do
    user = User.new()
    id=user.match(params['email'], params['password'])
    session[:user_id]=id[0][0]
    "User seccessfully logged in with id #{id[0][0]}"
end 
#This action require a user to be logged in. It will receive a new password and will update it. It returns the user created
put '/users' do
    user = User.new()
    id = session[:user_id]
    if id
        user.update(id, 'password', params['password'])
        "successfully updated user"
    else
        "Not authorized user"
    end  
end
#This action require a user to be logged in. It will sign_out the current user. It returns nothing
delete '/sign_out' do
    user = User.new()
    id = session[user_id]
    if id
        session.delete('user_id')
    else 
        "Not authorized"
    end
end
#This action require a user to be logged in. It will sign_out the current user and it will destroy the current user. It returns nothing
delete '/users' do 
    user = User.new()
    id = session[user_id]
    if id 
        user.destroy(id)
        session.delete('user_id')
    else 
        "Not authorized"
    end 
end