# coding: utf-8

module ReminderRobot
  class Robot
    class Reply
      class Pattern

        def initialize(config)
          @config = config
          instance_eval (RR.root + 'config/pattern.rb').read
        end

        def call(status)
          return false unless text = status.text
          @pattern.each {|key,value| return value.sample if text.match(key)}
          return false
        end

        private

        def keyword(regxp)
          @pattern ||= {}
          @pattern[regxp] = yield
        end
      end
    end
  end
end
