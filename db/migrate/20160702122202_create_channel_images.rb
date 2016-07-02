class CreateChannelImages < ActiveRecord::Migration
  def change
    create_table :channel_images do |t|
      t.string :title
      t.string :url
      t.string :link
      t.integer :width
      t.integer :height
      t.references :channel, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
