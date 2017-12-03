require 'space_invaders_detector/radar'

RSpec.describe SpaceInvadersDetector::Radar do
  context 'no samples' do
    let(:map) { %w(o- -o) }

    it 'found zero invaders' do
      subject.load_map map
      expect(subject.invaders).to be_empty
    end
  end

  context 'empty map' do
    let(:map) { %w(-- --) }
    let(:invader_sample) { %w(o) }

    it 'found zero invaders' do
      subject.load_map map
      subject.add_invader_sample invader_sample
      expect(subject.invaders).to be_empty
    end
  end

  context 'sample same with map' do
    let(:map) { %w(oo oo) }
    let(:invader_sample) { map }

    it 'found one invader' do
      subject.load_map map
      subject.add_invader_sample invader_sample
      expect(subject.invaders.size).to eq(1)
    end
  end

  context 'map with invaders' do
    let(:map) { %w(o- -o) }
    let(:invader_sample) { map }

    it 'found some invaders' do
      subject.load_map map
      subject.add_invader_sample invader_sample
      expect(subject.invaders.size).to eq(2)
    end
  end
end
