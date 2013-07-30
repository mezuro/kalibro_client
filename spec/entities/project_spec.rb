require 'spec_helper'

describe KalibroEntities::Entities::Project do
  describe 'id=' do
    it 'should set the value of the attribute id' do
      subject.id = 42
      subject.id.should eq(42)
    end
  end

  describe 'all' do
    context 'with no projects' do
      before :each do
        KalibroEntities::Entities::Project.expects(:request).with(:all_projects).returns({:project => nil})
      end

      it 'should return nil' do
        KalibroEntities::Entities::Project.all.should be_empty
      end
    end

    context 'with many projects' do
      before :each do
        @hash = KalibroEntities::Entities::Project.new.to_hash
        KalibroEntities::Entities::Project.expects(:request).with(:all_projects).returns({:project => [@hash, @hash]})
      end

      it 'should return nil' do
        projects = KalibroEntities::Entities::Project.all

        projects.first.name.should eq(@hash[:name])
        projects.last.name.should eq(@hash[:name])
      end
    end
  end
end