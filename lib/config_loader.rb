# coding: utf-8

module ReminderRobot
  class ConfigLoader
    class << self
      def load(path = 'config/config.yml')
        Hashie::Mash.new(YAML.load_file(RR.root + path))
      end
    end
  end
end
