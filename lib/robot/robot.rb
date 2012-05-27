# coding: utf-8

require_relative 'filter'
require_relative 'reply'
Dir[RR.root + 'lib/robot/reply/*.rb'].each {|f| require f}

module ReminderRobot
  class Robot
    
    def initialize
      load_config

      Signal.trap :HUP do
        load_config
      end
    end

    def load_config
      @config = ConfigLoader.load

      TweetStream.configure do |config|
        config.consumer_key = @config.twitter.consumer_key
        config.consumer_secret = @config.twitter.consumer_secret
        config.oauth_token = @config.twitter.oauth_token
        config.oauth_token_secret = @config.twitter.oauth_token_secret
        config.auth_method = :oauth
        config.parser   = :yajl
      end
      @stream_client = TweetStream::Client.new

      Twitter.configure do |config|
        config.consumer_key = @config.twitter.consumer_key
        config.consumer_secret = @config.twitter.consumer_secret
        config.oauth_token = @config.twitter.oauth_token
        config.oauth_token_secret = @config.twitter.oauth_token_secret
      end
      @twitter_client = Twitter::Client.new
      @config.self_screen_name = @twitter_client.verify_credentials.screen_name

      @filter = Filter.new(@config)
      @reply  = Reply.new(@config)
    end

    def run
      File.open('tmp/robot_pid.txt','w'){ |f| f.write Process.pid }
      @stream_client.userstream do |status|
        next unless @filter.catch(status)
        @reply.call(status)
      end
    end

    def cli
      loop do
        print "✖╹◡╹✖  > "
        text = gets.chomp
        break if text == "exit"
        status = Hashie::Mash.new(text: text)
        puts  "✖Ｘ◡Ｘ✖ : #{@reply.call(status)}"
      end
    end
  end
end


