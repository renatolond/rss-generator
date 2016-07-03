FactoryGirl.define do
  factory :channel_item do
    sequence(:title) { |n| "Channel Item ##{n}" }
    sequence(:link) { |n| "www.channel#{n}.com" }
    sequence(:guid) { |n| "channel.item.#{n}" }
    pubdate Time.now.to_date
    description '<img alt="blah" />';
  end
end
