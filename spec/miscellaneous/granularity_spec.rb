require 'spec_helper'

describe KalibroClient::Miscellaneous::Granularity do
  describe 'method' do
    describe 'initialize' do
      context 'with a valid type' do
        it 'should return an instance of Granularity' do
          expect(KalibroClient::Miscellaneous::Granularity.new(:SOFTWARE)).to be_a(KalibroClient::Miscellaneous::Granularity)
        end
      end

      context 'with a invalid type' do
        it 'should raise a TypeError' do
          expect { KalibroClient::Miscellaneous::Granularity.new(:MCC) }.to raise_error(TypeError)
        end
      end
    end

    describe 'parent' do
      context 'with a SOFTWARE granularity' do
        subject { FactoryGirl.build(:granularity) }

        it 'should return SOFTWARE' do
          expect(subject.parent.type).to eq(KalibroClient::Miscellaneous::Granularity::SOFTWARE)
        end
      end

      context 'with a METHOD granularity' do
        subject { FactoryGirl.build(:granularity, type: KalibroClient::Miscellaneous::Granularity::METHOD) }

        it 'should return CLASS' do
          expect(subject.parent.type).to eq(KalibroClient::Miscellaneous::Granularity::CLASS)
        end
      end
    end

    describe 'Comparison Operators' do
      subject { FactoryGirl.build(:granularity, type: KalibroClient::Miscellaneous::Granularity::CLASS) }
      context 'comparing to a greater one' do
        let(:other_granularity) { FactoryGirl.build(:granularity, type: KalibroClient::Miscellaneous::Granularity::SOFTWARE) }
        it 'should return true when checking for <' do
          expect(subject < other_granularity).to be_truthy
        end
        it 'should return true when checking for <=' do
          expect(subject <= other_granularity).to be_truthy
        end
        it 'should return false when checking for >' do
          expect(subject > other_granularity).to be_falsey
        end
        it 'should return false when checking for >=' do
          expect(subject >= other_granularity).to be_falsey
        end
      end

      context 'comparing to an equal one' do
        let(:other_granularity) { FactoryGirl.build(:granularity, type: KalibroClient::Miscellaneous::Granularity::CLASS) }
        it 'should return false when checking for <' do
          expect(subject < other_granularity).to be_falsey
        end
        it 'should return true when checking for <=' do
          expect(subject <= other_granularity).to be_truthy
        end
        it 'should return false when checking for >' do
          expect(subject > other_granularity).to be_falsey
        end
        it 'should return true when checking for >=' do
          expect(subject >= other_granularity).to be_truthy
        end
      end

      context 'comparing to a smaller one' do
        let(:other_granularity) { FactoryGirl.build(:granularity, type: KalibroClient::Miscellaneous::Granularity::METHOD) }
        it 'should return false when checking for <' do
          expect(subject < other_granularity).to be_falsey
        end
        it 'should return false when checking for <=' do
          expect(subject <= other_granularity).to be_falsey
        end
        it 'should return true when checking for >' do
          expect(subject > other_granularity).to be_truthy
        end
        it 'should return true when checking for >=' do
          expect(subject >= other_granularity).to be_truthy
        end
      end
    end

    describe 'to_s' do
      subject { FactoryGirl.build(:granularity) }

      it 'is expected to return the type as a string' do
        expect(subject.to_s).to eq(subject.type.to_s)
      end
    end
  end
end
