class CreateChannelItems < ActiveRecord::Migration
  def change
    create_table :channel_items do |t|
      t.string :title
      t.string :link
      t.string :guid
      t.datetime :pubdate
      t.text :description

      t.timestamps null: false
    end
  end
end
