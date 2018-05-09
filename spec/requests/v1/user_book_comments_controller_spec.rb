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

  describe '#create' do
    let(:request_url) { '/v1/user_book_comments' }
    let(:book) { create(:book) }
    let(:user) { create(:user) }

    before do
      user_id = user.id
      token = 'aaaaaaa'
      user.authentication_token = user_id.to_s + ':' + token
      user.save!
    end

    context 'normal pattern' do
      it 'create user_book_comment' do
        before_count = UserBookComment.count
        post request_url, params: { book_id: book.id, comment: 'testtest' },
             headers: { 'Authorization' => user.id.to_s + ':aaaaaaa' }
        expect(response.status).to eq 200
        expect(UserBookComment.count).to eq before_count + 1
      end

      it 'return 404 when book is not found' do
        post request_url, params: { book_id: book.id + 1, comment: 'testtest' },
             headers: { 'Authorization' => user.id.to_s + ':aaaaaaa' }
        expect(response.status).to eq 404
      end
    end
  end

  describe '#update' do
    let(:request_url) { '/v1/user_book_comments/' }
    let(:user_book_comment) { create(:user_book_comment, user_id: user.id) }
    let(:user) { create(:user) }

    before do
      user_id = user.id
      token = 'aaaaaaa'
      user.authentication_token = user_id.to_s + ':' + token
      user.save!
    end

    context 'normal pattern' do
      it 'create user_book_comment' do
        patch request_url + user_book_comment.id.to_s, params: { comment: 'testtest' },
             headers: { 'Authorization' => user.id.to_s + ':aaaaaaa' }
        expect(response.status).to eq 200
        after_user_book_comment = UserBookComment.find(user_book_comment.id)
        expect(after_user_book_comment.comment).to eq 'testtest'
      end

      it 'when user don\'t have target user_book_comment return 400' do
        patch request_url + (user_book_comment.id + 1).to_s, params: { comment: 'testtest' },
               headers: { 'Authorization' => user.id.to_s + ':aaaaaaa' }
        expect(response.status).to eq 400
      end
    end
  end

  describe '#destroy' do
    let(:request_url) { '/v1/user_book_comments/' }
    let(:user) { create(:user) }
    let(:user_book_comment) { create(:user_book_comment, user_id: user.id) }

    before do
      user_id = user.id
      token = 'aaaaaaa'
      user.authentication_token = user_id.to_s + ':' + token
      user.save!
    end

    it 'delete a record has target id' do
      delete request_url + user_book_comment.id.to_s,
             headers: { 'Authorization' => user.id.to_s + ':aaaaaaa' }
      expect(response.status).to eq 200
      expect(UserBookComment.where(id: user_book_comment.id).size).to eq 0
    end

    it 'when user don\'t have target user_book_comment return 400' do
      delete request_url + (user_book_comment.id + 1).to_s,
             headers: { 'Authorization' => user.id.to_s + ':aaaaaaa' }
      expect(response.status).to eq 400
    end
  end
end
