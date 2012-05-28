# coding: utf-8

module ReminderRobot
  class Robot
    class Reply

      def initialize(config)
        Dir[File.dirname(__FILE__) + '/reply/*.rb'].each { |f| load f }
        @config = config
        @random = (RR.root + 'config/random.txt').read.split(/\n/)
        @reminder = Reminder.new(config)
        @pattern  = Pattern.new(config)
      end

      def call(status)
        [@reminder, @pattern].each do |robot| 
          tweet = robot.call(status)
          return reply(tweet,status) if tweet
        end

        reply(@random.sample,status)
      end

      private

      def reply(tweet,status)
        if status.test.nil?
          tweet = "@#{status.user.screen_name} #{tweet}" if status.test.nil?
        else
          tweet
        end
      end
    end
  end
end
