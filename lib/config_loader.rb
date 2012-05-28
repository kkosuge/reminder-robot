# coding: utf-8

module ReminderRobot
  class ConfigLoader
    class << self
      def load
        Hashie::Mash.new(YAML.load_file(RR.root + 'config/config.yml')[RR.env])
      end

      def database
        Hashie::Mash.new(YAML.load_file(RR.root + 'db/config.yml')[RR.env])
      end
    end
  end
end
