# coding: utf-8

root = File.dirname(__FILE__)
$LOAD_PATH.unshift File.join(root, 'lib')
ENV['BUNDLE_GEMFILE'] ||= File.join(root, 'Gemfile')

require 'bundler'
Bundler.require
require 'reminder_robot'
require 'optparse'

OptionParser.new do |opt|
  opt.on('-C', 'CLI モード'){ @cli = true  }
  opt.on('-D', 'daemonize'){ RR.daemon = true }
  opt.on('-E', 'environment'){ |e| RR.env = e  }
end.parse!(ARGV)

if @cli
  ReminderRobot::Robot.new.cli
else
  ReminderRobot::Reminder.new.run
  ReminderRobot::Robot.new.run
end
