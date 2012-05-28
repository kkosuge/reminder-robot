# coding: utf-8

module ReminderRobot
  class Robot
    class Reply
      class Reminder

        def initialize(config)
          @config = config
        end

        def call(status)
          @status = status
          return tweet
        end

        private

        def set_record(datetime)
          ReminderRecord.create(
            status_id: @status.id_str,
            screen_name: @status.user.screen_name,
            text: @status.text,
            remind_time: datetime
          )
        end

        def todo
          dd = Horai::Parser::DATE_DELIMITER
          td = Horai::Parser::TIME_DELIMITER
          todo = @status.text.gsub(@config.filter.include,'')
                   .gsub(/^.+(?:に(?:なったら)?)/,'')
                   .gsub( /(?<![\d\/-])(?<!\d)(\d{1,2})#{dd}(\d{1,2})(?!#{dd})/,'')
                   .gsub(/(?<![\d\/-])(\d{1,2}|\d{4})#{dd}(\d{1,2})#{dd}(\d{1,2})(?!#{dd})/,'')
                   .gsub(/(?<![\d:])(\d{1,2})#{td}(\d{2})(?!#{td})/,'')
                   .gsub(/(?<![\d:])(\d{1,2})#{td}(\d{2})#{td}(\d{2})(?!#{td})/,'').chomp
        end

        def affix
          @config.reply.reminder.affix.sample
        end

        def tweet
          return false unless datetime = Horai.parse(@status.text)
          set_record(datetime) if @status.test.nil?

          if todo == ''
            "#{datetime}に通知します"
          else
            "#{datetime}に#{todo} #{affix}"
          end
        end
      end
    end
  end
end
