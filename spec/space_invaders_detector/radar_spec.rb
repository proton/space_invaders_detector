require 'space_invaders_detector/radar'

RSpec.describe SpaceInvadersDetector::Radar do
  let(:accuracy) { described_class::ACCURACY }

  shared_examples 'found required invaders' do
    subject { described_class.new(accuracy: accuracy) }

    before(:each) do
      subject.load_map(map)
      invader_samples.each do |sample|
        subject.add_invader_sample sample
      end
    end

    it 'found required invaders' do
      expect(subject.invaders.size).to eq(invaders_count)
    end
  end

  context 'no samples' do
    let(:map) { SpaceInvadersDetector::Image.new %w(o- -o) }
    let(:invader_samples) { [g] }
    let(:invaders_count) { 0 }

    include_examples 'found required invaders'
  end

  context 'empty map' do
    let(:map) { SpaceInvadersDetector::Image.new %w(-- --) }
    let(:invader_samples) { [SpaceInvadersDetector::Image.new(%w(o))] }
    let(:invaders_count) { 0 }

    include_examples 'found required invaders'
  end

  context 'sample same with map' do
    let(:map) { SpaceInvadersDetector::Image.new 'spec/support/files/map2.txt' }
    let(:invader_samples) { [map] }
    let(:invaders_count) { 1 }

    include_examples 'found required invaders'
  end

  context 'map with invaders' do
    let(:map) { SpaceInvadersDetector::Image.new %w(o- -o) }
    let(:invader_samples) { [SpaceInvadersDetector::Image.new(%w(o))] }
    let(:invaders_count) { 2 }

    include_examples 'found required invaders'
  end

  context 'real data' do
    let(:map) { SpaceInvadersDetector::Image.new 'spec/support/files/map2.txt' }
    let(:invader_samples) do
      %w(invader_0.txt invader_1.txt).map do |file_name|
        SpaceInvadersDetector::Image.new "spec/support/files/#{file_name}"
      end
    end
    let(:invaders_count) { 2 }

    include_examples 'found required invaders'
  end
end
