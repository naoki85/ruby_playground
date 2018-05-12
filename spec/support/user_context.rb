shared_context 'user_authenticated' do
  let(:user) { create(:user) }

  before do
    user.authentication_token = 'aaaaaaa'
    user.authentication_token_expired_at = DateTime.tomorrow
    user.save!
  end
end