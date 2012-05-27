# coding: utf-8

module ReminderRobot
  class Reminder
    def run
      Thread.new do
        loop do
          sleep 1
          puts 1
        end
      end
    end
  end
end
