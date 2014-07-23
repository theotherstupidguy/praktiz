require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/pride'


$:.unshift File.expand_path(File.dirname(__FILE__) + '/..')

require 'lib/praktiz-redis/base'

describe Praktiz::Persistence::DS, "redis datastore" do


  before do 
    Praktiz::Env.id = "123"
    @my_obj = Praktiz::Persistence::DS.new "myobject" 
    @subject = Praktiz::Persistence::DS.new @my_obj
  end

  it "contains an ID" do 
    @subject.must_respond_to :id 
    @subject.id.must_equal "123"
  end

  it "stores env object" do
    Praktiz::Persistence::DS.store @my_obj 
    @subject.exists?("123").must_equal true
  end
  it "loads env object" do 
    Praktiz::Persistence::DS.load("123").id.must_equal @my_obj.id
  end
end
