class AddIndexMessages < ActiveRecord::Migration
  def change
    add_index :messages, [:notice_id, :locale], unique: true
    change_column :messages, :locale, :string, null: false
  end
end
