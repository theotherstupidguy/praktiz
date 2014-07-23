require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/pride'

$:.unshift File.expand_path(File.dirname(__FILE__) + '/..')

require 'lib/praktiz/base'

describe Praktiz::Middleware do
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
    p subject
    subject.must_respond_to :find
  end
end
