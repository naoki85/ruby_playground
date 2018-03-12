require 'rails_helper'

RSpec.describe Publisher, type: :model do
  describe 'validate' do
    context '#name' do
      it { should validate_length_of(:name).is_at_most(64) }
    end
  end
end
