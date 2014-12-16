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
          expect(subject.prefix_options[:reading_group_id]).to eq(subject.reading_group.id)
        end

        it 'should not modify the prefix options' do
          expect(KalibroClient::Configurations::Reading.prefix).to eq "/"
        end
      end

      context 'with an invalid reading' do
        it 'should have the default prefix options' do
          expect(KalibroClient::Configurations::Reading.prefix).to eq "/"
        end

        it 'should not save the reading' do
          expect(KalibroClient::Configurations::Reading.new.save).to be_falsey
        end

        it 'should not modify the prefix options' do
          expect(KalibroClient::Configurations::Reading.prefix).to eq "/"
        end
      end
    end


    describe 'destroy' do
      context 'with a valid reading' do
        it 'should have the default prefix options' do
          expect(KalibroClient::Configurations::Reading.prefix).to eq "/"
        end

        it 'should not modify the prefix options after deletion' do
          subject.destroy
          expect(KalibroClient::Configurations::Reading.prefix).to eq "/"
        end
      end

      context 'with an invalid reading' do
        it 'should have the default prefix options' do
          expect(KalibroClient::Configurations::Reading.prefix).to eq "/"
        end

        it 'should not modify the prefix options after exception' do
          KalibroClient::Configurations::Reading.new.destroy
          expect(KalibroClient::Configurations::Reading.prefix).to eq "/"
        end
      end
    end
  end
end
