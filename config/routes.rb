
Rails.application.routes.draw do

  resources :folders
  resources :assets

  devise_for :users
  # Define root URI
  devise_scope :user do
  	authenticated :user do
      #Naming the root routes causes mailboxer to crash when email is sent. Do not uncomment till fixed
    	root :to => 'pages#launchpad'#, as: :authenticated_root
  	end
  	unauthenticated :user do

    	root :to => 'devise/registrations#new'#, as: :unauthenticated_root
  	end
  end
  	
  # Match routes for static pages
  get '/launchpad' => 'pages#launchpad'
  get '/add_push_session' => 'pages#add_push_session'
  get "/contacts/create_session/:id" => "contacts#create_session", as: :create_session
  post "/contacts/create_appointment/:id" => "contacts#create_appointment", as: :create_appointment

  post "/contacts/set_customer/:id" => "contacts#set_customer"
  get "/contacts/get_customer/:id" => "contacts#get_customer"
  
  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent
  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash
  get "/contacts/mail_session/:id" => "contacts#mail_session", as: :mail_session
  get "/conversations/new_wrecp" => "conversations/new_wrecp", as: :conv_session
  post "/conversations/invite" => "conversations#invite", as: :invite
  #Route for webcast
  get '/webcast' => 'contacts#webcast'

  get '/assets' => 'assets#index'
  #This route is for file downloads 
  match "assets/get/:id" => "assets#get", :via => [:get], :as => "download"
  #To browse across folders
  match "browse/:folder_id" => "assets#browse",  :via => [:get], :as => "browse"
 
  #creating folders insiide another folder 
  match "browse/:folder_id/new_folder" => "folders#new", :via => [:get], :as => "new_sub_folder"

  #for uploading files to folders 
  match "browse/:folder_id/new_file" => "assets#new", :via => [:get], :as => "new_sub_file"
  #for renaming a folder 
  match "browse/:folder_id/rename" => "folders#edit", :via => [:get], :as => "rename_folder"

  #for sharing the folder 
  match "assets/share" => "assets#share", :via => [:post], :as => "share"

  resources :appointments, except: [:create, :edit, :show, :update, :destroy, :new]
  post '/appointments/make_payment/:id' => "appointments#make_payment", as: :make_payment

  # Resourceful routes for the contacts page
  resources :contacts , except: [:show, :destroy]do
    member do
      get :delete
    end  
  end  
  resources :conversations do
    resources :messages
    member do
      post :reply
      post :trash
      post :untrash
    end
  end
end

