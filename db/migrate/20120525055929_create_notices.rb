class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.datetime :close_at
      t.timestamps
    end
  end
end
