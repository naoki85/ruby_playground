require 'rails_helper'

RSpec.describe Admin::UsersController, type: :request do
  describe 'Create a user' do
    it 'invalid signup information' do
      before_count = User.count
      post sign_up_path, params: { user: { email: "user@invalid", password: "foo" } }
      expect(User.count).to eq before_count
      expect(response.body.include?('Sign Up')).to eq true
    end

    it 'valid signup information' do
      before_count = User.count
      post sign_up_path, params: { user: { email: "user@gmail.com", password: "foobar" } }
      expect(User.count).to eq before_count + 1
      p response.body
      expect(response.status).to eq 302
    end
  end
end
