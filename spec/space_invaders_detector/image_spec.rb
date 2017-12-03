require 'space_invaders_detector/image'

RSpec.describe SpaceInvadersDetector::Image do
  describe '#load_image' do
    let(:array) { %w(--o -o-) }

    it 'loads successfully' do
      subject.load_image array

      expect(subject.width).to eq(3)
      expect(subject.height).to eq(2)
      expect(subject[0, 0]).to eq(0)
      expect(subject[0, 2]).to eq(1)
      expect(subject[1, 1]).to eq(1)
    end
  end

  describe '#load_image_file' do
    let(:image_path) { 'spec/support/files/invader_0.txt' }

    it 'loads successfully' do
      subject.load_image_file image_path

      expect(subject.width).to eq(11)
      expect(subject.height).to eq(8)
      expect(subject[0, 0]).to eq(0)
      expect(subject[0, 2]).to eq(1)
      expect(subject[1, 3]).to eq(1)
    end
  end
end
