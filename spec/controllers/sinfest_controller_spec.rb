require 'rails_helper'

RSpec.describe SinfestController, type: :controller do
  ITEMS_TO_FETCH = SinfestController::ITEMS_TO_FETCH
  describe 'GET#index' do
    before(:each) do
      @channel = FactoryGirl.create(:channel_sinfest)
      @stub = stub_request(:get, /.*sinfest\.net.*/)
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

      #when
      get :index

      #then
      expect(a_request(:get, /.*sinfest\.net.*/)).to have_been_made.times(ITEMS_TO_FETCH)
    end
  end
end
