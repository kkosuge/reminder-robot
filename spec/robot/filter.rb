# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')

describe ReminderRobot::Robot::Filter do
  before do
    @config = ReminderRobot::ConfigLoader.load
  end

  context 'リプライが含まれなかったとき' do
    before do
      @status = Hashie::Mash.new(text: "matz")
      @filter = ReminderRobot::Robot::Filter.new(@config)
    end
    
    it 'false を返す' do
      @filter.catch(@status).should be_false
    end
  end

  context 'リプライが含まれるとき' do
    context '除外キーワードが含まれるとき' do
      before do
        @status = Hashie::Mash.new(text: "【拡散】RT @reminder_robot ニャーン")
        @filter = ReminderRobot::Robot::Filter.new(@config)
      end

      it 'false を返す' do
        @filter.catch(@status).should be_false
      end
    end

    context '除外キーワードが含まれない' do
      before do
        @status = Hashie::Mash.new(text: "@reminder_robot ニャーン")
        @filter = ReminderRobot::Robot::Filter.new(@config)
      end

      it 'true を返す' do
        @filter.catch(@status).should be_true
      end
    end
  end
end
