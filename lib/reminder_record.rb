# coding: utf-8

require 'active_record'

module ReminderRobot

  ActiveRecord::Base.establish_connection(
    :adapter  => "sqlite3",
    :database => "#{RR.root.to_s}/db/development.sqlite3",
    :timeout  => 5000
  )

  class ReminderRecord < ActiveRecord::Base
    self.table_name = :reminders
  end
end
