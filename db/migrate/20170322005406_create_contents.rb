class CreateContents < ActiveRecord::Migration[5.0]
  def change
    create_table :contents do |t|
      t.text :origin_url
      t.string :h1, array: true, default: []
      t.string :h2, array: true, default: []
      t.string :h3, array: true, default: []
      t.string :links, array: true, default: []

      t.timestamps
    end
  end
end
