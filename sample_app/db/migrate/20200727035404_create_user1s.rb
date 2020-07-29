class CreateUser1s < ActiveRecord::Migration[5.0]
  def change
    create_table :user1s do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
