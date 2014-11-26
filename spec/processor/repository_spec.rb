require 'kalibro_client'

describe KalibroClient::Processor::Repository, :type => :model do
  describe 'methods' do
    describe 'last_processing' do
      subject { FactoryGirl.build(:repository) }

      context 'with no processing at all' do
        before :each do
          subject.expects(:get).with(:has_ready_processing).returns(false)
          subject.expects(:get).with(:last_processing_in_time).returns({})
        end

        it 'should return nil' do
          expect(subject.last_processing).to be_a KalibroClient::Processor::Processing
        end
      end

      context 'with a ready processing' do
        let(:processing_params) { Hash[FactoryGirl.attributes_for(:processing).map { |k,v| [k.to_s, v.to_s] }] } #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with symbols and integers
        let(:processing) { FactoryGirl.build(:processing) }
        before :each do
          subject.expects(:get).with(:has_ready_processing).returns(true)
        end

        it 'should return a ready processing processing' do
          subject.expects(:get).with(:last_ready_processing).returns(processing_params)

          expect(subject.last_processing).to eq(processing)
        end
      end

      context 'with no ready processing' do
        let(:processing_params) { Hash[FactoryGirl.attributes_for(:processing, state: 'COLLECTING').map { |k,v| [k.to_s, v.to_s] }] } #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with symbols and integers
        let(:processing) { FactoryGirl.build(:processing, state: 'COLLECTING') }

        before :each do
          subject.expects(:get).with(:has_ready_processing).returns(false)
        end

        it 'should return the latest processing' do
          subject.expects(:get).with(:last_processing_in_time).returns(processing_params)

          expect(subject.last_processing).to eq(processing)
        end
      end

      describe 'has_processing' do
        it 'is expected to return true when there is a processing' do
          subject.expects(:get).with(:has_processing).returns(true)

          expect(subject.has_processing).to be_truthy
        end
      end
    end
  end
end
