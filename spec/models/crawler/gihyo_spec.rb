require 'rails_helper'

RSpec.describe Crawler::Gihyo, type: :model, skip: true do
  subject { Crawler::Gihyo }

  before do
    file_path = Rails.root.join('spec/fixtures/test_pages/gihyo/new_release.html').to_s
    html = File.read(file_path)
    allow(subject).to receive(:get_html_and_charset).and_return([html, 'utf-8'])
  end

  describe '.run' do
    it { expect(subject.run.count > 0).to eq true }
  end
end
