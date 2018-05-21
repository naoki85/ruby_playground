require 'rails_helper'

RSpec.describe V1::PublishersController, type: :request do

  describe '#index' do
    let(:request_url) { '/v1/publishers' }

    before do
      3.times do
        publisher = create(:publisher)
        5.times do
          create(:book, publisher_id: publisher.id)
        end
      end
    end

    it 'get publishers' do
      get request_url
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['publishers'].size).to eq 3
    end
  end

  describe '#show' do
    let(:request_url) { '/v1/publishers/' }
    let(:publisher) { create(:publisher) }

    before do
      5.times do
        create(:book, publisher_id: publisher.id)
      end
    end

    it 'get publisher data' do
      get request_url + publisher.id.to_s
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['publisher']['id']).to eq publisher.id
      expect(json['publisher']['books'].size).to eq 5
    end

    it 'when publisher is not found return 404 error' do
      get request_url + (publisher.id + 1).to_s
      expect(response.status).to eq 404
    end

    it 'when publisher is not active return 404 error' do
      publisher.active = 0
      publisher.save!
      get request_url + (publisher.id + 1).to_s
      expect(response.status).to eq 404
    end
  end
end
