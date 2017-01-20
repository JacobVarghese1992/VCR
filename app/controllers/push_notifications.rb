require 'net/http'
require 'uri'

class PushNotification
    
    attr_accessor :title
	attr_accessor :body
	attr_accessor :click
	attr_accessor :receiver
	attr_accessor :detail

	def initialize(title, body, click, receiver)
		@title = title.to_s
		@body = body.to_s
		@click = click.to_s
		@receiver = receiver
		@detail = User.find(receiver).push_details.last
	end		


	def push
		if (detail)
			send(detail.token)
		end		
	end	

	def send(token)
		
		uri = URI.parse("https://fcm.googleapis.com/fcm/send")
		request = Net::HTTP::Post.new(uri, initheader = {'Content-Type' =>'application/json'})
		request["Authorization"] = "key=AAAA1VIAL8o:APA91bEabWzsi5ygiOoiUiMsWtRXYvalv7eXEIgtjXAj7Ymp3MbgDbSl4-xepzRIBNIFPabkv68OJL1bx-86x5E9LtUG5gi1GOcIPmi-S5cMBeueVguLmRBBA7mCdFpOJh2tMVWKkEfuipcEM-6T8OXJRN4cLPNylA"
		request.body = "{\"to\":\"#{token}\",\"notification\":{\"title\":\"#{@title}\",\"body\":\"#{body}\",\"click_action\":\"#{click}\",\"icon\": \"https://medimailhub.herokuapp.com/final_round.png\"} \"priority:\"10}"

		response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
  		http.request(request)
		end
	end	

end	