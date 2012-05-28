# coding: utf-8

require 'active_record'

module ReminderRobot
  class ReminderRecord < ActiveRecord::Base
    establish_connection ConfigLoader.database 
    self.table_name = :reminders

    scope :before, lambda {|time| where("remind_time < ?", time) }
  end
end
