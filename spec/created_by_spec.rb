require File.dirname(__FILE__) + '/spec_helper'

class MockActiveRecord < ActiveRecord::Base
end

describe ActiveRecord::Base do
  it "includes ActiveRecord::Assocations::CreatedBy::ClassMethods" do
    ActiveRecord::Base.methods.should be_member('created_by')
  end
end

describe :created_by do
  it "creates the belongs_to :creator association with default options" do
    MockActiveRecord.should_receive(:belongs_to).with(:creator, :class_name => 'MockCreator', :foreign_key => 'created_by')
    MockActiveRecord.created_by :mock_creator
  end

  it "creates the belongs_to association with alternate foreign_key" do
    MockActiveRecord.should_receive(:belongs_to).with(:creator, :class_name => 'MockCreator', :foreign_key => 'creator_id')
    MockActiveRecord.created_by :mock_creator, :foreign_key => 'creator_id'
  end

  it "creates the belongs_to association with alternate class_name (but why?)" do
    MockActiveRecord.should_receive(:belongs_to).with(:creator, :class_name => 'AnotherClassName', :foreign_key => 'created_by')
    MockActiveRecord.created_by :mock_creator, :class_name => 'AnotherClassName'
  end

  it 'ignores all other options' do
    MockActiveRecord.should_receive(:belongs_to).with(:creator, :class_name => 'MockCreator', :foreign_key => 'created_by')
    MockActiveRecord.created_by :mock_creator, :foo => 'Bar'
  end

  it 'ignores options unless it is a Hash' do
    MockActiveRecord.should_receive(:belongs_to).with(:creator, :class_name => 'MockCreator', :foreign_key => 'created_by')
    MockActiveRecord.created_by :mock_creator, :foo
  end
end
