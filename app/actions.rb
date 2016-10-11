helpers do
    def current_user
        User.find_by(id: session[:user_id])
    end
end    

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
    
    #instantiate  a User
    @user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password })
    
    #if user validation pass and user is saved
    if @user.save
        redirect to('/login')
    
    else
    # display simple error message
   
    erb(:signup)
    end
end
get '/login' do
    
    erb(:login)    
    
end

post '/login' do
    
    username    = params[:username]
    password    = params[:password]
    
    #find user by username
    
    user = User.find_by(username: username)
    
    #if that user exists
    if user && user.password == password
        session[:user_id] = user.id
            redirect to('/')
        else
        @error_message = "Login failed."
        
        erb(:login)
    end
    
end    

get '/logout' do
    
    session[:user_id] = nil
    
    redirect to('/')
end  

get '/posts/new' do
    @post = Post.new
    erb(:"posts/new")
end

post '/posts' do
    
    photo_url = params[:photo_url]
    
    # instantiate new Post
    @post = Post.new({photo_url: photo_url, user_id: current_user.id})
    
    #if @post validates, save
    if @post.save
        redirect(to('/'))
    else
        
        #if i doesn't validate, print error messages
        erb(:"posts/new")
    end    
end
    
get '/posts/:id' do 
  
  @post = Post.find(params[:id])    #find the post with the id from the url
  erb (:"posts/show")

end

   
  
