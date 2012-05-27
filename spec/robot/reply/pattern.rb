# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '../../../spec_helper')

describe ReminderRobot::Robot::Reply::Pattern do
  before do
    @config = ReminderRobot::ConfigLoader.load
  end

  context 'パターンが含まれないとき' do
    before do
      @status = Hashie::Mash.new(text: "matz")
      @robot = ReminderRobot::Robot::Reply::Pattern.new(@config)
    end
    
    it 'false を返す' do
      @robot.call(@status).should be_false
    end
  end

  context '時刻が含まれるとき' do
    before do
      @status = Hashie::Mash.new(text: "寝る")
      @robot = ReminderRobot::Robot::Reply::Pattern.new(@config)
    end

    it 'Stringを返す' do
      @robot.call(@status).class.should be String
    end
  end
end
