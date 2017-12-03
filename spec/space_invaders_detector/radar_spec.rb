require 'space_invaders_detector/radar'

RSpec.describe SpaceInvadersDetector::Radar do
  let(:accuracy) { described_class::ACCURACY }
  let(:map_presence) { described_class::MAP_PRESENCE }

  shared_examples 'found required invaders' do
    subject { described_class.new(accuracy: accuracy, map_presence: map_presence) }

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
    let(:invader_samples) { [] }
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
    let(:invader_samples) do
      %w(invader_0.txt invader_1.txt).map do |file_name|
        SpaceInvadersDetector::Image.new "spec/support/files/#{file_name}"
      end
    end

    context 'map1' do
      let(:map) { SpaceInvadersDetector::Image.new 'spec/support/files/map.txt' }

      context 'accuracy 1.0' do
        let(:accuracy) { 1.0 }
        let(:invaders_count) { 0 }
        include_examples 'found required invaders'
      end

      context 'accuracy 0.9' do
        let(:accuracy) { 0.9 }
        let(:invaders_count) { 1 }
        include_examples 'found required invaders'
      end

      context 'accuracy 0.8' do
        let(:accuracy) { 0.8 }
        let(:invaders_count) { 8 }
        include_examples 'found required invaders'
      end
    end

    context 'map2' do
      let(:map) { SpaceInvadersDetector::Image.new 'spec/support/files/map2.txt' }

      context 'accuracy 1.0' do
        let(:accuracy) { 1.0 }
        let(:invaders_count) { 1 }
        include_examples 'found required invaders'
      end

      context 'accuracy 0.9' do
        let(:accuracy) { 0.9 }
        let(:invaders_count) { 2 }
        include_examples 'found required invaders'
      end

      context 'accuracy 0.8' do
        let(:accuracy) { 0.8 }
        let(:invaders_count) { 2 }
        include_examples 'found required invaders'
      end
    end

    context 'map3' do
      let(:map) { SpaceInvadersDetector::Image.new 'spec/support/files/map3.txt' }

      context 'map_presence 1.0' do
        let(:map_presence) { 1.0 }

        context 'accuracy 1.0' do
          let(:accuracy) { 1.0 }
          let(:invaders_count) { 0 }
          include_examples 'found required invaders'
        end

        context 'accuracy 0.9' do
          let(:accuracy) { 0.9 }
          let(:invaders_count) { 0 }
          include_examples 'found required invaders'
        end
      end

      context 'map_presence 0.8' do
        let(:map_presence) { 0.5 }

        context 'accuracy 1.0' do
          let(:accuracy) { 1.0 }
          let(:invaders_count) { 0 }
          include_examples 'found required invaders'
        end

        context 'accuracy 0.9' do
          let(:accuracy) { 0.9 }
          let(:invaders_count) { 1 }
          include_examples 'found required invaders'
        end
      end
    end
  end
end
