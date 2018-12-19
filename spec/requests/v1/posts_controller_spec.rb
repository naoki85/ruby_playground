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

    it do
      8.times { create(:post, active: 1, published_at: Time.zone.now.yesterday) }
      get request_url
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['posts'].size).to eq 10
      expect(json['posts'][0]['post_category'].size).to eq 3
      expect(json['total_page']).to eq 2

      get request_url + '?page=2'
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['posts'].size).to eq 1
    end
  end

  describe '#show' do
    let(:request_url) { '/v1/posts/' }

    context 'normal pattern' do
      let(:post) { create(:post) }

      it do
        get request_url + post.id.to_s
        expect(response.status).to eq 200
        json = JSON.parse(response.body)
        expect(json['post']['id']).to eq post.id
        expect(json['post']['post_category']['name']).to eq 'Ruby'

        get request_url + (post.id + 1).to_s
        expect(response.status).to eq 404
      end
    end

    context 'case params have preview' do
      let(:post) { create(:post, active: 0) }

      it 'should get post before released ' do
        get request_url + post.id.to_s + '?preview=true'
        expect(response.status).to eq 200
        json = JSON.parse(response.body)
        expect(json['post']['id']).to eq post.id

        get request_url + post.id.to_s
        expect(response.status).to eq 404
      end
    end
  end

  describe '#create', skip: true do
    let(:request_url) { '/v1/posts' }

    before do
      create(:post_category, id: 0, name: 'test')
    end

    include_context 'user_authenticated'

    it 'create post' do
      before_count = Post.count
      post request_url,
           params: { title: 'new', summary: 'new', content: 'new', published_at: '2018-05-01 00:00:00' },
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

  describe '#update', skip: true do
    let(:request_url) { '/v1/posts/' }
    let(:post) { create(:post, user_id: user.id) }

    include_context 'user_authenticated'

    it 'update post' do
      patch request_url + post.id.to_s,
            params: { title: 'new', summary: 'new', content: 'new', published_at: '2018-05-01 00:00:00' },
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

  describe '#destroy', skip: true do
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

  describe '#upload' do
    let(:request_url) { '/v1/posts/upload' }

    context 'success to upload' do
      before do
        allow_any_instance_of(AwsS3::Resource).to receive(:upload).and_return('test.txt')
      end

      it do
        post request_url, params: { file: fixture_file_upload('test.png', 'image/png', true) }
        expect(response.status).to eq 200
        json = JSON.parse(response.body)
        expect(json['image_url'].include?('test.txt')).to eq true
      end
    end

    context 'fail to upload' do
      before do
        allow_any_instance_of(AwsS3::Resource).to receive(:upload).and_return(nil)
      end

      it do
        post request_url, params: { file: fixture_file_upload('test.png', 'image/png', true) }
        expect(response.status).to eq 400
      end
    end
  end

  describe '#ogp' do
    let(:request_url) { '/v1/posts/ogp' }
    let(:params_url) { CGI.escape('https://blog.bookrecorder.net') }

    before do
      file_path = Rails.root.join('spec/fixtures/test_pages/ogp/sample_page.html').to_s
      html = File.read(file_path)
      html = Nokogiri::HTML.parse(html, nil, 'utf-8')
      allow(controller).to receive(:read_html).and_return(html)
    end

    it do
      get request_url + '?url=' + params_url
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['url']).to eq 'https://blog.bookrecorder.net/'
      expect(json['title']).to eq 'ブログ一覧 | BookRecorder'
      expect(json['description'].present?).to eq true
      expect(json['image_url'].present?).to eq true
    end
  end
end
