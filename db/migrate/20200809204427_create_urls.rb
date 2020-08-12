class CreateUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :urls do |t|
      t.string :long_url
      t.string :slug

      t.timestamps
    end
  end
end
