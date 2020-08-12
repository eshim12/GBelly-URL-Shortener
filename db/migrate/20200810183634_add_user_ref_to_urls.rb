class AddUserRefToUrls < ActiveRecord::Migration[5.1]
  def change
    add_reference :urls, :user, foreign_key: true
  end
end
