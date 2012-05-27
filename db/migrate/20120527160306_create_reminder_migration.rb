class CreateReminderMigration < ActiveRecord::Migration
  def self.up
    create_table :reminders do |t|
      t.string  :status_id
      t.string  :screen_name
      t.string  :text
      t.text    :remind_time

      t.timestamps
    end
  end

  def self.down
    drop_table :reminders
  end
end
