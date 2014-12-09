require 'kalibro_client'

describe KalibroClient::Processor::Repository, :type => :model do
  describe 'methods' do
    subject { FactoryGirl.build(:repository) }

    describe 'last_processing' do
      context 'with no processing at all' do
        before :each do
          response = mock('response')
          response.expects(:body).returns("{}")
          subject.expects(:get).with(:has_ready_processing).returns(false)
          subject.expects(:post).with(:last_processing).returns(response)
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
          response = mock('response')
          response.expects(:body).returns(processing_params.to_json)
          subject.expects(:post).with(:last_processing).returns(response)

          expect(subject.last_processing).to eq(processing)
        end
      end
    end

    describe 'has_processing' do
      it 'is expected to return true when there is a processing' do
        subject.expects(:get).with(:has_processing).returns(true)

        expect(subject.has_processing).to be_truthy
      end
    end

    describe 'module_result_history_of' do
      let!(:module_result) {FactoryGirl.build(:module_result)}
      let!(:time) { Time.now }
      before :each do
        response = mock('response')
        response.expects(:body).returns({module_result_history_of: [[time, module_result]]}.to_json)
        subject.expects(:post).with(:module_result_history_of, module_id: module_result.kalibro_module.id).returns(response)

        @history = subject.module_result_history_of(module_result)
      end

      it 'is expected to return just one DateModuleResult' do
        expect(@history.count).to eq(1)
      end

      it 'is expected to return the given module result and date' do
        expect(@history.first.date).to eq(Time.parse(time.to_json))
        expect(@history.first.module_result).to eq(module_result)
      end
    end

    describe 'metric_result_history_of' do
      let!(:module_result) {FactoryGirl.build(:module_result)}
      let!(:metric_result) {FactoryGirl.build(:metric_result)}
      let!(:time) { Time.now }
      before :each do
        response = mock('response')
        response.expects(:body).returns({metric_result_history_of: [[time, module_result]]}.to_json)
        subject.expects(:post).with(:metric_result_history_of, module_id: module_result.kalibro_module.id, metric_name: metric_result.metric.name).returns(response)

        @history = subject.metric_result_history_of(module_result, metric_result)
      end

      it 'is expected to return just one DateMetricResult' do
        expect(@history.count).to eq(1)
      end

      it 'is expected to return the given metric result and date' do
        expect(@history.first.date).to eq(Time.parse(time.to_json))
        expect(@history.first.metric_result).to eq(metric_result)
      end
    end
  end
end
