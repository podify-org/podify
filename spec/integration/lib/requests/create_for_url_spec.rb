require 'rails_helper'

RSpec.describe Requests::CreateForUrl do
  include Dry::Effects::Handler.Defer

  let(:url) { 'https://example.com/some-video' }
  let(:user) { create(:user) }
  let(:feed) { create(:feed, user: user) }

  let(:result) { subject.call(user: user, feed: feed, url: url) }
  let(:request) { result.value! }

  context 'when a source with the url does not exist yet' do
    it 'creates a source and request' do
      expect { with_defer { result } }
        .to change(Source, :count).by(1)
        .and change(Request, :count).by(1)
      expect(result).to be_success
      expect(request.source.url).to eq(url)
      expect(request.user).to eq(user)
    end
  end

  context 'when a source with the url already exists' do
    before do
      create(:source, url: url)
    end

    it 'creates the request' do
      expect { result }
        .to change(Source, :count).by(0)
        .and change(Request, :count).by(1)
      expect(result).to be_success
      expect(request.source.url).to eq(url)
      expect(request.user).to eq(user)
    end
  end
end
