class AddShortenedUrlToUrls < ActiveRecord::Migration[5.1]
  def change
    add_column :urls, :shortened_url, :string
  end
end
