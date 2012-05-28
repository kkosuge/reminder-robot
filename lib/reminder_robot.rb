# coding: utf-8

module ReminderRobot
  class << self
    def root
      @root ||= Pathname(__FILE__).dirname.realpath + '..'
    end

    def env
      @env ||= "development"
    end
  end
end

# Alias for {ReminderRobot}
RR = ReminderRobot

require 'pp'
require 'pathname'
require 'config_loader'
require 'reminder_record'
require 'robot/robot'
require 'reminder/reminder'

