require "twitter"
class TwitterNotifier
  def initialize(project)
    Twitter.configure do |config|
      config.consumer_key = "YOUR CONSUMER KEY"
      config.consumer_secret = "YOUR CONSUMER SECRET"
      config.oauth_token = "YOUR OAUTH TOKEN"
      config.oauth_token_secret = "YOUR TOKEN SECRET"
    end
    
    @client = Twitter::Client.new
    
    def build_finished(build)
      @client.update("#{build.project.name} build #{build.label} BROKEN!") if build.failed?
    end

    def build_fixed(build, previous_build)
      @client.update("#{build.project.name} build #{build.label} FIXED build #{previous_build.label}!")
    end
  end
end
Project.plugin :twitter_notifier
