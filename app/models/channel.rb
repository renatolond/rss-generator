class Channel < ActiveRecord::Base
  enum channel_type: [ :sinfest ]

  has_many :channel_items
  has_one :channel_image
end
