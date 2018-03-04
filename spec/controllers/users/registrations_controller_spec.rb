require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  describe '#update_resource' do
    subject { Users::RegistrationsController.new }
    let(:user) { create(:user) }

    context 'user regist from social' do
      before do
        user.provider = 'twitter'
        user.uid = 'aaaaaaa'
        user.save!
      end
      it 'unnecessary current password' do
        params = { email: 'test@example.com' }
        tmp_user = user
        expect(subject.instance_eval { update_resource(tmp_user, params) }).to eq true
      end
    end

    context 'user regist from login form' do
      it 'necessary current password' do
        params = { email: 'test@example.com', password: '', password_confirmation: '', current_password: '123456789' }
        tmp_user = user
        expect(subject.instance_eval { update_resource(tmp_user, params) }).to eq true
      end
    end
  end
end
