class AddChannelToChannelItems < ActiveRecord::Migration
  def change
    add_reference :channel_items, :channel, index: true, foreign_key: true
  end
end
