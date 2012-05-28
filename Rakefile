# coding: utf-8

ENV['env'] ||= 'development'

begin
  require 'tasks/standalone_migrations'
rescue LoadError => e
  puts "gem install standalone_migrations to get db:migrate:* tasks! (Error: #{e})"
end

desc "reload config (default: env='development')"
task :reload do
  pid = File.open("tmp/#{ENV['env']}_pid.txt").read.chomp.to_i
  puts "kill -HUP #{pid}"
  Process.kill(:HUP, pid)
end

desc "kill (default: env='development')"
task :kill do
  pid = File.open("tmp/#{ENV['env']}_pid.txt").read.chomp.to_i
  puts "kill #{pid}"
  Process.kill(:KILL, pid)
end
