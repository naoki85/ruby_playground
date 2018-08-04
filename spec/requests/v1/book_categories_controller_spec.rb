require 'rails_helper'

RSpec.describe V1::BookCategoriesController, type: :request do
  describe '#index' do
    let(:request_url) { '/v1/book_categories' }

    before do
      5.times do
        create(:book_category, pickup_flag: 1)
      end
      create(:book_category, pickup_flag: 0)
    end

    it do
      get request_url
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['book_categories'].size).to eq 5
    end
  end
end
