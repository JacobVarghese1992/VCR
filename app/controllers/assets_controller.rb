require "#{Rails.root}/app/controllers/push_notifications"

class AssetsController < ApplicationController
  before_action :authenticate_user!  #authenticate for users before any methods is called
  before_action :set_asset, only: [:show, :edit, :update, :destroy]

  # GET /assets
  # GET /assets.json
 


def index 
    if user_signed_in? 
      #show folders shared by others 
      @being_shared_folders = current_user.shared_folders_by_others 
    
      #show only root folders 
      @folders = current_user.folders.roots 
      #show only root files 
      @assets = current_user.assets.where("folder_id is NULL").order("uploaded_file_file_name desc")       
    end
end
  # GET /assets/1
  # GET /assets/1.json
  def show
  end

  # GET /assets/new
  # def new
  #   @asset = current_user.assets.new
  # end

  def new
  @asset = current_user.assets.new     
  if params[:folder_id] #if we want to upload a file inside another folder 
   @current_folder = current_user.folders.find(params[:folder_id]) 
   @asset.folder_id = @current_folder.id 

  end
end

  # GET /assets/1/edit
  def edit
  end

  # POST /assets
  # POST /assets.json
  #  def create
  #    @asset = current_user.assets.new(asset_params)

  #    respond_to do |format|
  #      if @asset.save
  #        format.html { redirect_to @asset, notice: 'Asset was successfully created.' }
  #        format.json { render :show, status: :created, location: @asset }
  #      else
  #        format.html { render :new }
  #        format.json { render json: @asset.errors, status: :unprocessable_entity }
  #      end
  #    end
  # end


 def create 
   puts asset_params.inspect

   @asset = current_user.assets.new(asset_params)

   if @asset.save 
    flash[:notice] = "Successfully uploaded the file."
  
    if @asset.folder #checking if we have a parent folder for this file 
      # redirect_to '/assets'
      redirect_to browse_path(@asset.folder)  #then we redirect to the parent folder 
    else
      redirect_to '/assets' 
    end      
   else
    puts "+-=-=-"
    
    puts @asset.inspect
    render 'new'
   end
 end




  # # PATCH/PUT /assets/1
  # # PATCH/PUT /assets/1.json
  # def update
  #   respond_to do |format|
  #     if @asset.update(asset_params)
  #       format.html { redirect_to @asset, notice: 'Asset was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @asset }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @asset.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /assets/1
  # DELETE /assets/1.json
  # def destroy
  #   @asset.destroy
  #   respond_to do |format|
  #     format.html { redirect_to assets_url, notice: 'Asset was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end


def destroy 
  @asset = current_user.assets.find(params[:id]) 
  @parent_folder = @asset.folder #grabbing the parent folder before deleting the record 
  @asset.destroy 
  flash[:notice] = "Successfully deleted the file."
  
  #redirect to a relevant path depending on the parent folder 
  if @parent_folder
   redirect_to browse_path(@parent_folder) 
  else
   redirect_to '/assets' 
  end
end




  #This action will let the users download the files (after a simple authorization check) 
  # def get 
  #   asset = current_user.assets.find_by_id(params[:id]) 
  #     if asset 
  #        send_file asset.uploaded_file.path, :type => asset.uploaded_file_content_type 
  #     else
  #       flash[:error] = "Don't be cheeky! Mind your own assets!"
  #       redirect_to assets_path
  #     end
  # end


  def get 
 #first find the asset within own assets 
 asset = current_user.assets.find_by_id(params[:id]) 
  
 #if not found in own assets, check if the current_user has share access to the parent folder of the File 
 asset ||= Asset.find(params[:id]) if current_user.has_share_access?(Asset.find_by_id(params[:id]).folder) 
  
 if asset 
   #Parse the URL for special characters first before downloading 
   # data = open(URI.parse(URI.encode(asset.uploaded_file.url))
   send_file asset.uploaded_file.path, :type => asset.uploaded_file_content_type  
   # send_data data, :filename => asset.uploaded_file_file_name 
   #redirect_to asset.uploaded_file.url 
 else
   flash[:error] = "Don't be cheeky! Mind your own assets!"
     redirect_to assets_path 
 end
end

  #this action is for viewing folders 
# def browse 
#     #get the folders owned/created by the current_user 
#     @current_folder = current_user.folders.find(params[:folder_id])   
  
#     if @current_folder
#        #if under a sub folder, we shouldn't see shared folders 
#       @being_shared_folders = []
    
#       #getting the folders which are inside this @current_folder 
#       @folders = @current_folder.children 
  
#       #We need to fix this to show files under a specific folder if we are viewing that folder 
#      # @assets = current_user.assets.order("uploaded_file_file_name desc") 
#        #show only files under this current folder 
#       @assets = @current_folder.assets.order("uploaded_file_file_name desc")
  
#       render "index"
#     else
#       flash[:error] = "Don't be cheeky! Mind your own folders!"
#       redirect_to '/assets' 
#     end
# end



def browse 
  #first find the current folder within own folders 
  @current_folder = current_user.folders.find_by_id(params[:folder_id])   
  @is_this_folder_being_shared = false if @current_folder #just an instance variable to help hiding buttons on View 
    
  #if not found in own folders, find it in being_shared_folders 
  if @current_folder.nil? 
    folder = Folder.find_by_id(params[:folder_id]) 
      
    @current_folder ||= folder if current_user.has_share_access?(folder) 
    @is_this_folder_being_shared = true if @current_folder #just an instance variable to help hiding buttons on View 
      
  end
    
  if @current_folder
       #if under a sub folder, we shouldn't see shared folders 
      @being_shared_folders = []
    
      #getting the folders which are inside this @current_folder 
      @folders = @current_folder.children 
  
      #We need to fix this to show files under a specific folder if we are viewing that folder 
     # @assets = current_user.assets.order("uploaded_file_file_name desc") 
       #show only files under this current folder 
      @assets = @current_folder.assets.order("uploaded_file_file_name desc")
  
      render "index"
    else
      flash[:error] = "Don't be cheeky! Mind your own folders!"
      redirect_to '/assets' 
    end
end







 


#this handles ajax request for inviting others to share folders 
def share     

    people = params[:people]  
      
    people.each do |user_id| 
      #getting the shared user id right the owner the email has already signed up with ShareBox 
      #if not, the field "shared_user_id" will be left nil for now. 
      shared_user = User.find(user_id.to_i)

      #save the details in the ShareFolder table 
      @shared_folder = current_user.shared_folders.new
      @shared_folder.folder_id = params[:folder_id] 
      @shared_folder.shared_email = shared_user.email

       
    
       
      @shared_folder.shared_user_id = shared_user.id if shared_user 
    
      @shared_folder.message = params[:message] 
      @shared_folder.save 
    

      notification = PushNotification.new("Shared Document", "#{current_user.first_name} #{current_user.last_name} has shared documents with you", assets_url, shared_user.id)
      notification.push()
     #now we need to send email to the Shared User 
    end
  
    #since this action is mainly for ajax (javascript request), we'll respond with js file back (refer to share.js.erb) 
    respond_to do |format| 
      format.js { 
      } 
    end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset
      @asset = current_user.assets.find(params[:id]) 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asset_params
      params.require(:asset).permit(:user_id, :uploaded_file, :folder_id, :parent_id,  :shared_email, :shared_user_id,  :message)
    end
end
