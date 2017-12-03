require 'space_invaders_detector/image'

RSpec.describe SpaceInvadersDetector::Image do
  context 'loading from file' do
    let(:image_path) { 'spec/support/files/invader_0.txt' }

    it 'loads successfully' do
      subject.load_image_file image_path
      expect(subject.width).to eq(11)
      expect(subject.height).to eq(8)
    end
  end
end
