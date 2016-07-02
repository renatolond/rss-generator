require 'rails_helper'

RSpec.describe SinfestController, type: :controller do
  ITEMS_TO_FETCH = 2
  describe 'GET#index' do
    before(:each) do
      @channel = FactoryGirl.create(:channel_sinfest)
      @stub = stub_request(:get, /.*sinfest\.net.*/)
      Timecop.travel('2016-07-01 12:00:00'.to_datetime)
      stub_const('SinfestController::ITEMS_TO_FETCH', ITEMS_TO_FETCH - 1)
    end

    after(:each) do
      Timecop.return
    end

    it 'Get index with channel updated should not call sinfest' do
      #given
      @channel.last_build_date = Time.now
      @channel.save

      #when
      get :index

      #then
      expect(@stub).not_to have_been_requested
    end

    it 'Get index with channel updated should render index template' do
      #given
      @channel.last_build_date = Time.now
      @channel.save

      #when
      get :index

      #then
      expect(response).to render_template :index
    end

    it "Get index with channel more than one day old should get sinfest #{ITEMS_TO_FETCH} times" do
      #given
      @channel.last_build_date = 3.days.ago
      @channel.save

      #when
      get :index

      #then
      expect(a_request(:get, /.*sinfest\.net.*/)).to have_been_made.times(ITEMS_TO_FETCH)
    end

    it "Get index with channel more than one day old should insert stubbed items in channel" do
      #given
      @channel.last_build_date = 3.days.ago
      @channel.save
      stub1 = stub_request(:get, 'http://www.sinfest.net/view.php?date=2016-06-30').to_return(body: File.read('spec/page_body.txt'), status: 200)
      item1 = ChannelItem.new(title: 'June 30, 2016: Hero 2', link: 'http://www.sinfest.net/view.php?date=2016-06-30', guid: 'sinfest-imgs-2016-06-30', pubdate: '2016-06-30', channel_id: @channel.id, description: '<img src="http://www.sinfest.net/btphp/comics/2016-06-30.gif" border="0" alt="Hero 2">')
      stub2 = stub_request(:get, 'http://www.sinfest.net/view.php?date=2016-07-01').to_return(body: File.read('spec/page2_body.txt'), status: 200)
      item2 = ChannelItem.new(title: 'July  1, 2016: Sweep 5', link: 'http://www.sinfest.net/view.php?date=2016-07-01', guid: 'sinfest-imgs-2016-07-01', pubdate: '2016-07-01', channel_id: @channel.id, description: '<img src="http://www.sinfest.net/btphp/comics/2016-07-01.gif" border="0" alt="Sweep 5">')

      exceptions = %w(id created_at updated_at)

      #when
      get :index
      @channel.reload

      #then
      expect(@channel.channel_items.count).to eq(2)
      expect(@channel.channel_items[0].attributes.except(*exceptions)).to eq(item1.attributes.except(*exceptions))
      expect(@channel.channel_items[1].attributes.except(*exceptions)).to eq(item2.attributes.except(*exceptions))
    end
  end
end
