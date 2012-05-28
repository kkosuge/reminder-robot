# coding: utf-8

module ReminderRobot
  class Reminder

    def initialize
      @config = ConfigLoader.load
    end

    def run
      Thread.new do
        loop do
          check_record
          sleep 3
        end
      end
    end

    private

    def twitter
      @twitter ||= lambda do
        Twitter.configure do |config|
          config.consumer_key = @config.twitter.consumer_key
          config.consumer_secret = @config.twitter.consumer_secret
          config.oauth_token = @config.twitter.oauth_token
          config.oauth_token_secret = @config.twitter.oauth_token_secret
        end

        Twitter::Client.new
      end.call
    end

    def check_record
      ReminderRecorder.before(Time.now).each do |task|
        update_tweet task
        task.delete
      end
    end

    def update_tweet(task)
      twitter.update(
        "@#{task.screen_name} http://twitter.com/#{task.screen_name}/status/#{task.status_id} #{@config.reminder.affix.sample}",
        :in_reply_to_status_id => task.status_id
      )
    end
  end
end
