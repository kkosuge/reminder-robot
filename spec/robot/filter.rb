# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')

describe ReminderRobot::Robot::Filter do
  before do
    @config = ReminderRobot::ConfigLoader.load
    @filter = ReminderRobot::Robot::Filter.new(@config)
  end

  context 'リプライが含まれなかったとき' do
    before do
      status = {
        :text => "matz",
        :user => { :screen_name => "9m" }
      }
      @status = Hashie::Mash.new(status)
    end
    
    it 'false を返す' do
      @filter.catch(@status).should be_false
    end
  end

  context 'リプライが含まれるとき' do
    context '除外キーワードが含まれるとき' do
      before do
        status = {
          :text => "【拡散】 RT @reminder_robot ニャーン",
          :user => { :screen_name => "matz" }
        }
        @status = Hashie::Mash.new(status)
      end

      it 'false を返す' do
        @filter.catch(@status).should be_false
      end
    end

    context '除外キーワードが含まれない' do
      before do
        status = {
          :text => "@reminder_robot ニャーン",
          :user => { :screen_name => "T7" }
        }
        @status = Hashie::Mash.new(status)
      end

      it 'true を返す' do
        @filter.catch(@status).should be_true
      end

      context '短時間に５回以上リプライが来る' do
        before do
          status = {
            :text => "@reminder_robot ニャーン",
            :user => { :screen_name => "JustinBieber" }
          }
          @status = Hashie::Mash.new(status)
          5.times { @filter.catch(@status) }
        end

        it 'false を返す' do
          @filter.catch(@status).should be_false
        end

        context '１分間隔を空けた場合' do
          before do
            status = {
              :text => "@reminder_robot ニャーン",
              :user => { :screen_name => "JustinBieber" }
            }
            @status = Hashie::Mash.new(status)
            5.times { @filter.catch(@status) }
          end

          it 'true を返す' do
            pending("１分待つの…")
            sleep 60
            @filter.catch(@status).should be_true
          end
        end

        context '複数アカウントから来た場合' do
          before do
            status = {
              :text => "@reminder_robot ニャーン",
              :user => { :screen_name => "masason" }
            }
            5.times {
              @status = Hashie::Mash.new(status)
              @filter.catch(@status)
            }
            status = {
              :text => "@reminder_robot ニャーン",
              :user => { :screen_name => "neko" }
            }
            @status = Hashie::Mash.new(status)
          end
          
          it 'true を返す' do
            @filter.catch(@status).should be_true
          end
        end
      end
    end
  end
end
