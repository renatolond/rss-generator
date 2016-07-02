class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :title
      t.string :link
      t.text :description
      t.datetime :last_build_date

      t.timestamps null: false
    end
  end
end
