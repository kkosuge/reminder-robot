# coding: utf-8

module ReminderRobot
  class Robot
    class Filter

      def initialize(config)
        @include = config.filter.include
        @exclude = config.filter.exclude
        @self_screen_name = config.screen_name
      end

      def catch(status)
        return false unless status.text
        return false unless status.text.match(@include)
        return false if status.text.match(@exclude)
        return true
      end
    end
  end
end
