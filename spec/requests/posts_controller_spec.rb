require 'rails_helper'

RSpec.describe PostsController, type: :request, skip: true do
  describe '#show' do
    let(:post) { create(:post) }

    it do
      get "/posts/#{post.id}"
      expect(response.status).to eq 302
      expect(response.header['Location']).to eq "https://blog.naoki85.me/posts/#{post.id}"
    end
  end
end
