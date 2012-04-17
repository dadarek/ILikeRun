class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :password
      t.string :salt

      t.timestamps
    end
  end
end
