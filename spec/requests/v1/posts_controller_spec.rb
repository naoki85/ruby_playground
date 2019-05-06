require 'rails_helper'

RSpec.describe V1::PostsController, type: :request do
  before do
    allow_any_instance_of(V1::PostsController).to receive(:logged_in?).and_return(true)
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

    context 'unless logged in' do
      before do
        allow_any_instance_of(V1::PostsController).to receive(:logged_in?).and_return(false)
      end

      it do
        post request_url, params: { file: fixture_file_upload('test.png', 'image/png', true) }
        expect(response.status).to eq 401
      end
    end
  end

  describe '#ogp' do
    let(:request_url) { '/v1/posts/ogp' }
    let(:params_url) { CGI.escape('https://blog.bookrecorder.net') }

    before do
      allow(OgpParser).to receive(:parse).and_return(
        title: "ブログ一覧 | BookRecorder",
        description: "カンファレンスで登壇して良かったことと反省 Zabbix で Nginx + PHP を監視するサンプルを作ってみた Real World HTTP を読みました PHP-FPM のプロセス",
        image: "https://blog.bookrecorder.net/assets/commons/ogp-8c266fd8a086f156b935aa228f3771859b638cc5ef505c489b9f383510994364.png",
        url: "https://blog.bookrecorder.net/"
      )
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
