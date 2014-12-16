require 'kalibro_client'

describe KalibroClient::Configurations::Reading, :type => :model do
  describe 'methods' do
    subject { FactoryGirl.build(:reading) }

    describe 'save' do
      context 'with a valid reading' do
        it 'should have the default prefix options' do
          expect(KalibroClient::Configurations::Reading.prefix).to eq "/"
        end

        it 'should save the reading' do
          KalibroClient::Configurations::Base.any_instance.expects(:save).returns(true)
          expect(subject.save).to be_truthy
          expect(subject.prefix_options[:reading_group_id]).to eq(subject.reading_group_id)
        end

        it 'should not modify the prefix options' do
          expect(KalibroClient::Configurations::Reading.prefix).to eq "/"
        end
      end
    end

    describe 'destroy' do
      context 'with a valid reading' do
        let(:reading) { FactoryGirl.build(:processing, state: 'COLLECTING') }

        it 'should have the default prefix options' do
          expect(KalibroClient::Configurations::Reading.prefix).to eq "/"
        end

        it 'should destroy the reading' do
          KalibroClient::Configurations::Base.any_instance.expects(:destroy).returns(true)
          expect(subject.destroy).to be_truthy
          expect(subject.prefix_options[:reading_group_id]).to eq(subject.reading_group_id)
        end

        it 'should not modify the prefix options' do
          expect(KalibroClient::Configurations::Reading.prefix).to eq "/"
        end
      end
    end
  end
end
