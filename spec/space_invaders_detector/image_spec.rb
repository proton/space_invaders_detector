require 'space_invaders_detector/image'

RSpec.describe SpaceInvadersDetector::Image do
  let(:image_array) { %w(--o -o-) }
  let(:image_path) { 'spec/support/files/image.txt' }

  shared_examples 'loads successfully' do
    it 'loads successfully' do
      expect(subject.width).to eq(3)
      expect(subject.height).to eq(2)
      expect(subject[0, 0]).to eq(0)
      expect(subject[0, 2]).to eq(1)
      expect(subject[1, 1]).to eq(1)
    end
  end

  describe '#initialize' do
    context 'with array' do
      let(:init_data) { image_array }
      subject { described_class.new(init_data) }

      include_examples 'loads successfully'
    end

    context 'with file path' do
      let(:init_data) { image_path }
      subject { described_class.new(init_data) }

      include_examples 'loads successfully'
    end
  end

  describe '#load_image' do
    before(:each) do
      subject.load_image_file image_path
    end

    include_examples 'loads successfully'
  end

  describe '#load_image_file' do
    before(:each) do
      subject.load_image image_array
    end

    include_examples 'loads successfully'
  end

  describe '#area' do
    before(:each) { subject.load_image image_array }

    it 'equals to with * height' do
      expect(subject.area).to eq(6)
    end
  end

  describe '#has_cords?' do
    before(:each) { subject.load_image image_array }

    context 'good cords' do
      it 'returns true' do
        expect(subject.has_cords? 0, 0).to be_truthy
        expect(subject.has_cords? 1, 2).to be_truthy
      end
    end

    context 'bad cords' do
      it 'returns false' do
        expect(subject.has_cords? -1, 0).to be_falsey
        expect(subject.has_cords? 1, 3).to be_falsey
      end
    end
  end
end
