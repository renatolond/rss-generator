require 'curb'

class SinfestController < ApplicationController
  EXPIRE_AFTER = 24.hours
  ITEMS_TO_FETCH = 7
  FIRST_COMIC_DATE = '2000-01-17'.to_date
  def index
    @channel = Channel.find_by_channel_type(Channel.channel_types[:sinfest])
    if (@channel.last_build_date < Time.now - EXPIRE_AFTER) then
      update_sinfest
    end
    render formats: :xml
  end

  def update_sinfest
    start_date = ITEMS_TO_FETCH.days.ago
    if(start_date < FIRST_COMIC_DATE) then
      start_date = FIRST_COMIC_DATE
    end

    date = start_date
    today = Time.now.to_date
    ActiveRecord::Base.transaction do
      @channel.channel_items.destroy_all

      while date.to_date <= today do
        pubdate = date.to_date.to_s

        link = "http://www.sinfest.net/view.php?date=#{pubdate}"

        c = Curl::Easy.new(link) do |curl|
          curl.headers['User-Agent'] = 'rss-generator-1.0'
        end
        c.perform

        if(c.status.include? '200') then
          html_doc = Nokogiri::HTML(c.body)
          title = html_doc.xpath('/html/body/div/table[4]/tr[1]/td/table/tbody/tr[1]/td').text
          description = html_doc.xpath('/html/body/div/table[4]/tr[1]/td/table/tbody/tr[2]/td').children.to_s
          description.gsub!(/btphp/, 'http://www.sinfest.net/btphp')
          description.gsub!(/alt/, 'border="0" alt')
          guid = "sinfest-imgs-#{pubdate}"
          ChannelItem.create(link: link, pubdate: pubdate, title: title, description: description, channel: @channel, guid: guid)
        end

        date += 1.day
      end

      @channel.last_build_date = Time.now
      @channel.save
      @channel.reload
    end
  end
end
