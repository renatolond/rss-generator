class SinfestController < ApplicationController
  def index
    @channel = Channel.find_by_channel_type(Channel.channel_types[:sinfest])
    render formats: :xml
  end
end
