require "#{Rails.root}/app/controllers/push_notifications"
class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
    @registrations = current_user.registrations
    puts "========================"
    puts (@registrations.find_by_course_id(1))
    puts (@registrations.find_by_course_id(3))
    puts "========================"

    @user = current_user
  end


  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def attend

    registration = Registration.new
    registration.course_id = params[:id]
    registration.user_id = current_user.id
    registration.save


    redirect_to courses_path
    # @course.destroy
    # respond_to do |format|
    #   format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  def start_teaching

    # Create a new session if dialed via the contact page
    opentok = OpenTok::OpenTok.new(API_OPENTOK[:key], API_OPENTOK[:secret])
    # Create a session id
    session_id = opentok.create_session.session_id
    puts "+++++++++++++++++++="
    puts session_id
    puts "++++++++++++++++++++"

    course = Course.find(params[:id])
    course.session_id = session_id
    course.save
    # Update session id to the current user database
    # current_user.session_id = session_id
    # current_user.save
    # contact = User.find(params[:id])
    # # Update session id to the contacts database
    # contact.session_id = session_id
    # contact.save
    
    # notification = PushNotification.new("Incoming call", "#{current_user.first_name} #{current_user.last_name} is calling you", webcast_url, contact.id)
    # notification.push()

    redirect_to courses_path
    # redirect_to(:action => "webcast")

  end

  def start_learning



    # Update session id to the current user database
    # current_user.session_id = session_id
    # current_user.save
    # contact = User.find(params[:id])
    # # Update session id to the contacts database
    # contact.session_id = session_id
    # contact.save
    
    # notification = PushNotification.new("Incoming call", "#{current_user.first_name} #{current_user.last_name} is calling you", webcast_url, contact.id)
    # notification.push()

    redirect_to webcast_path
    # redirect_to(:action => "webcast")

  end

  def webcast
    
    # opentok = OpenTok::OpenTok.new(API_OPENTOK[:key], API_OPENTOK[:secret])
    # @session_id = current_user.session_id
    # if (@session_id.empty?)
    #   redirect_to(:action => "index")   
    # else
    #   @token = opentok.generate_token(@session_id)
    # end  
      @user = current_user.first_name + ' ' + current_user.last_name  
      @role = current_user.role
      opentok = OpenTok::OpenTok.new(API_OPENTOK[:key], API_OPENTOK[:secret])
    if current_user.role != "patient"

      # Create a session id
      @session_id = opentok.create_session.session_id
      puts "+++++++++++++++++++="
      puts @session_id
      puts "++++++++++++++++++++"

      course = Course.find(params[:id])
      course.session_id = @session_id
      course.save
    else
      course = Course.find(params[:id])
      @session_id = course.session_id
    end  

    if (@session_id.empty?)
      redirect_to(:action => "index")   
    else

      users = Course.find(params[:id]).users
      users.each do |user|
        notification = PushNotification.new("Course started", "Course #{course.name} has started", webcast_url(params[:id]), user.id)
        notification.push()
      end

      @token = opentok.generate_token(@session_id)
    end 

    
  end


  def watch
    opentok = OpenTok::OpenTok.new(API_OPENTOK[:key], API_OPENTOK[:secret])
    course = Course.find_by_course_id(params[:id])
    @session = Hash.new

    @session["session_id"] = course.session_id
    @session["token"] = opentok.generate_token(course.session_id)
    respond_to do |format|
      format.html
      format.json { render json: @session }
    end


  end   

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:course_id, :name)
    end




end

