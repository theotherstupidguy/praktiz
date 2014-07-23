# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "praktiz-redis"
  spec.version       = "0.0.0.pre1"
  spec.authors       = [""]
  spec.email         = [""]
  spec.summary       = "" 
  spec.description   = ""
  spec.homepage      = ""
  spec.license       = ""

  spec.files       =  Dir.glob("{lib}/**/*")  
  spec.require_paths = ["lib"]
end
