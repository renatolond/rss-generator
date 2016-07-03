FactoryGirl.define do
  factory :channel_image do
    sequence(:title) {|n| "Channel Image ##{n}"}
    sequence(:url) { |n| "www.channel#{n}.com/image.img" }
    sequence(:link) { |n| "www.channel#{n}.com" }
    width 16
    height 16
  end
end
