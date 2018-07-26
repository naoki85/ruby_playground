require 'rails_helper'

RSpec.describe V1::BookCategoriesController, type: :request do
  describe '#index' do
    let(:request_url) { '/v1/book_categories' }

    before do
      create_list(:book_category, 10)
    end

    it do
      get request_url
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['book_categories'].size).to eq 10
    end
  end
end
