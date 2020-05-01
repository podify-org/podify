require 'rails_helper'

RSpec.describe Sources::ImportFile do
  let(:path) { file_fixture('example.mp4') }
  let(:result) { subject.call(path) }

  context 'when a source with the file does not exist yet' do
    it 'creates a source' do
      expect { result }.to change(Source, :count).by(1)
      expect(result).to be_success
      expect(result.value!.url).to eq("file://#{path.expand_path.realpath}")
    end
  end

  context 'when a source with the file already exists' do
    before do
      subject.call(path)
    end

    it 'returns the source' do
      expect { result }.not_to change(Source, :count)
      expect(result).to be_success
      expect(result.value!.url).to eq("file://#{path.expand_path.realpath}")
    end
  end
end
