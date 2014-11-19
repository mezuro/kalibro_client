require 'kalibro_client'

describe KalibroClient::Processor::Repository, :type => :model do
  describe 'methods' do
    describe 'last_processing' do
      subject { FactoryGirl.build(:repository) }

      context 'with no processing at all' do
        before :each do
          subject.expects(:get).with(:has_ready_processing).returns(false)
          subject.expects(:get).with(:last_processing_in_time).returns(nil)
        end

        it 'should return nil' do
          expect(subject.last_processing).to be_nil
        end
      end

      context 'with a ready processing' do
        let(:processing) { FactoryGirl.build(:processing) }

        before :each do
          subject.expects(:get).with(:has_ready_processing).returns(true)
        end

        it 'should return a ready processing processing' do
          subject.expects(:get).with(:last_ready_processing).returns(processing)

          expect(subject.last_processing).to eq(processing)
        end
      end

      context 'with no ready processing' do
        let(:processing) { FactoryGirl.build(:processing, state: 'COLLECTING') }

        before :each do
          #subject.expects(:get).with(:has_processing).returns(true)
          subject.expects(:get).with(:has_ready_processing).returns(false)
        end

        it 'should return the latest processing' do
          subject.expects(:get).with(:last_processing_in_time).returns(processing)

          expect(subject.last_processing).to eq(processing)
        end
      end
    end
  end
end
