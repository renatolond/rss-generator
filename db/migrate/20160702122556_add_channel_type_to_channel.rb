class AddChannelTypeToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :channel_type, :integer
  end
end
