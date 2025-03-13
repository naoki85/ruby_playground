require 'rails_helper'

RSpec.describe PostCategory, type: :model do
  describe 'validate' do
    context '#name' do
      it { should validate_length_of(:name).is_at_most(64) }
    end

    context '#color' do
      it { should validate_length_of(:color).is_at_most(8) }
    end
  end
end
