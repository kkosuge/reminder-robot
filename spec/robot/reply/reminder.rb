# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '../../../spec_helper')

describe ReminderRobot::Robot::Reply::Reminder do
  before do
    @config = ReminderRobot::ConfigLoader.load
  end

  context '時刻が含まれないとき' do
    before do
      @status = Hashie::Mash.new(text: "@reminder_robot ニャーン")
      @robot = ReminderRobot::Robot::Reply::Reminder.new(@config)
    end
    
    it 'false を返す' do
      @robot.call(@status).should be_false
    end
  end

  context '時刻が含まれるとき' do
    before do
      @status = Hashie::Mash.new(text: "@reminder_robot 15時におやつ〜〜")
      @robot = ReminderRobot::Robot::Reply::Reminder.new(@config)
    end

    it 'Stringを返す' do
      @robot.call(@status).class.should be String
    end
  end
end
