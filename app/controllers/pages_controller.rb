class PagesController < ApplicationController
  before_action :authenticate_user!

  def launchpad
  end

  def add_push_session
  	token = params[:token]
  	pd = PushDetail.new({:token=>token})
  	current_user.push_details.destroy_all
  	current_user.push_details << pd
  	render "pages/launchpad_noajax"
  end	

end
