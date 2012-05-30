# coding: utf-8

module ReminderRobot
  class Robot
    class Filter

      def initialize(config)
        @include = config.filter.include
        @exclude = config.filter.exclude
        @self_screen_name = config.screen_name
        @re ||= {}
      end

      def catch(status)
        return false unless status.text
        return false unless status.text.match(@include)
        return false if status.text.match(@exclude)
        return false if runaway(status)
        return true
      end

      private

      def runaway(status)
        result = 0
        @re[Time.now] = status.user.screen_name
        @re.each { |key,value| @re.delete(key) if key < 1.minutes.ago }
        @re.each { |key,value| result += 1 if value == status.user.screen_name }
        result > 4
      end
    end
  end
end
