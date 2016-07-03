FactoryGirl.define do
  factory :channel do
    sequence(:title) { |n| "Channel ##{n}" }
    sequence(:link) { |n| "www.channel#{n}.com" }
    description 'Just a random description'
    last_build_date 3.days.ago
    factory :channel_sinfest do
      channel_type Channel.channel_types[:sinfest]
    end

    association :channel_image, factory: :channel_image

    transient do
      items_count 3
    end

    after(:create) do |channel, evaluator|
      create_list(:channel_item, evaluator.items_count, channel: channel)
      channel.reload
    end
  end
end
