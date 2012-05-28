# coding: utf-8

root = File.dirname(__FILE__)
$LOAD_PATH.unshift File.join(root, 'lib')
ENV['BUNDLE_GEMFILE'] ||= File.join(root, 'Gemfile')

require 'bundler'
Bundler.require
require 'reminder_robot'

if ARGV.first == 'cli'
  ReminderRobot::Robot.new.cli
else
  ReminderRobot::Reminder.new.run
  ReminderRobot::Robot.new.run
end
