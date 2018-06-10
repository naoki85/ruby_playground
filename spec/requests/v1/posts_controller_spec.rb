require 'rails_helper'

RSpec.describe V1::PostsController, type: :request do
  describe '#index' do
    let(:request_url) { '/v1/posts' }

    before do
      3.times do
        create(:post, active: 1, published_at: Time.zone.now.yesterday)
        create(:post, active: 0, published_at: Time.zone.now.tomorrow)
      end
    end

    it do
      get request_url
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['posts'].size).to eq 3
    end
  end

  describe '#show' do
    let(:request_url) { '/v1/posts/' }
    let(:post) { create(:post) }

    it do
      get request_url + post.id.to_s
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['post']['id']).to eq post.id

      get request_url + (post.id + 1).to_s
      expect(response.status).to eq 404
    end
  end

  describe '#create' do
    let(:request_url) { '/v1/posts' }

    include_context 'user_authenticated'

    it 'create post' do
      before_count = Post.count
      post request_url,
           params: { post: { title: 'new', summary: 'new', content: 'new', published_at: '2018-05-01 00:00:00' } },
           headers: { 'Authorization' => 'aaaaaaa' }
      expect(response.status).to eq 200
      expect(Post.count).to eq before_count + 1
    end

    it 'return 400 when post params are invalid' do
      post request_url,
           params: { post: { title: '', summary: '', content: '', published_at: '2018-05-01 00:00:00' } },
           headers: { 'Authorization' => 'aaaaaaa' }
      expect(response.status).to eq 400
    end
  end

  describe '#update' do
    let(:request_url) { '/v1/posts/' }
    let(:post) { create(:post, user_id: user.id) }

    include_context 'user_authenticated'

    it 'update post' do
      patch request_url + post.id.to_s,
            params: { post: { title: 'new', summary: 'new', content: 'new', published_at: '2018-05-01 00:00:00' } },
            headers: { 'Authorization' => 'aaaaaaa' }
      expect(response.status).to eq 200
      after_post = Post.find(post.id)
      expect(after_post.title).to eq 'new'
    end

    it 'when user don\'t have target post return 400' do
      patch request_url + (post.id + 1).to_s,
            params: { post: { title: 'new', summary: 'new', content: 'new', published_at: '2018-05-01 00:00:00' } },
            headers: { 'Authorization' => 'aaaaaaa' }
      expect(response.status).to eq 400
    end
  end

  describe '#destroy' do
    let(:request_url) { '/v1/posts/' }
    let(:post) { create(:post, user_id: user.id) }

    include_context 'user_authenticated'

    it 'delete a record has target id' do
      delete request_url + post.id.to_s,
             headers: { 'Authorization' => 'aaaaaaa' }
      expect(response.status).to eq 200
      expect(Post.where(id: post.id).size).to eq 0
    end

    it 'when user don\'t have target post return 400' do
      delete request_url + (post.id + 1).to_s,
             headers: { 'Authorization' => 'aaaaaaa' }
      expect(response.status).to eq 400
    end
  end
end
