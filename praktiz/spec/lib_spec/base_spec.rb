require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/pride'


$:.unshift File.expand_path(File.dirname(__FILE__) + '/../..')

require 'lib/praktiz/base'

describe Praktiz::Middleware, "Praktize Domain Middlewares" do
  subject {Praktiz::Middleware} 
  it "must include mushin middleware" do 
    subject.must_include Mushin::Domain::Middleware
  end
end

describe Praktiz::DSL do
  subject {Praktiz::DSL} 
  it "must include mushin dsl" do 
    subject.must_include Mushin::DSL
  end
  it "#find" do 
    subject.must_respond_to :find
  end
end

describe Praktiz::Engine do
  subject {Praktiz::Engine} 
  it "must extend mushin engine" do 
    subject.must_be_kind_of Mushin::Engine
  end
  it "#run" do 
    subject.must_respond_to :run
  end
end

describe Praktiz::Env do
  subject {Praktiz::Env} 

  it "must extend Mushin::Env" do 
    subject.must_be_kind_of Mushin::Env
  end
  it "must have an ID" do 
    subject.must_respond_to :id
  end

  it "#set" do 
    subject.must_respond_to :set
  end

  it "#get" do 
    subject.must_respond_to :get
  end
  it "raise error if gets an ID" do 
    proc{subject.get("JamesBond")}.must_raise NotImplementedError
  end
end
