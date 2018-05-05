require 'rails_helper'

RSpec.describe V1::UserBookCommentsController, type: :request do
  describe '#index' do
    let(:request_url) { '/v1/user_book_comments' }
    before do
      create_list(:user_book_comment, 10)
    end

    it 'get comment list' do
      get request_url
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['return_code']).to eq 0
      expect(json['server_time']).to be_present
      expect(json['user_book_comments'].size).to eq 10
    end
  end
end
