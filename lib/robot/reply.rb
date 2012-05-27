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
          return tweet if tweet
        end

        @random.sample
      end
    end
  end
end
