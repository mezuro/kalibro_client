require 'kalibro_client'

describe KalibroClient::Configurations::Reading, :type => :model do
  describe 'methods' do
    subject { FactoryGirl.build(:reading) }

    describe 'reading_group_id=' do
      context 'with a valid reading' do
        let(:reading_group) { FactoryGirl.build(:reading_group, id: 94) } 

        it 'should modify the prefix options' do
          subject.reading_group_id = reading_group.id

          expect(subject.reading_group_id).to eq reading_group.id
          expect(subject.prefix_options[:reading_group_id]).to eq reading_group.id
        end
      end

    describe 'find' do
      context 'with no ready processing' do
        let(:processing) { FactoryGirl.build(:processing, state: 'COLLECTING') }

        before :each do
          KalibroClient::Configurations::Base.expects(:find).with(subject.id).returns(subject)
          p subject.class.prefix
        end

        it 'should have the default prefix options' do
          expect(KalibroClient::Configurations::Reading.prefix).to eq "/reading_groups/:reading_group_id/"
        end

      end
        it 'should return the reading' do
          expect(KalibroClient::Configurations::Reading.find(subject.id)).to eq subject
        end

        it 'should not modify the prefix options' do
          expect(KalibroClient::Configurations::Reading.prefix).to eq "/reading_groups/:reading_group_id/"
        end
      end
    end
  end
end
