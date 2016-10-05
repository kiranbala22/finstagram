
get '/' do
  
  @posts = Post.order(created_at: :desc)
  
   erb(:index)
end
 
get '/signup' do
    
  @user = User.new
    
    erb(:signup)
end
    
post '/signup' do
    
    # grab user input values from params
    email       = params[:email]
    avatar_url  = params[:avatar_url]
    username    = params[:username]
    password    = params[:password]
    
    #instantiate and save a User
    user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password })
    user.save
    
    #return readable representation of User object
    
    escape_html user.inspect

end    
  
