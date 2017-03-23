class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :api_key, null: false

      t.timestamps
    end
    add_column :contents, :user_id, :integer
  end
end
