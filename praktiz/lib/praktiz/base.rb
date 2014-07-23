module Praktiz
  module Middleware 
    include Mushin::Domain::Middleware
  end
  module DSL 
    include Mushin::DSL
    def self.find activity_context, activity_statment
      Mushin::DSL.middlewares = []
      Mushin::DSL.contexts.each do |current_context|
	if activity_context == current_context.title
	  current_context.statments.each do |statment|
	    if activity_statment == statment.title
	      statment.activations.each do |middleware|
		Mushin::DSL.middlewares << middleware 
	      end
	    end
	  end
	end
      end
      Mushin::DSL.middlewares
    end
  end
  module Engine
    extend Mushin::Engine
    class << self
      def run domain_context, activity
	@stack = Mushin::Middleware::Builder.new do
	(Praktiz::DSL.find domain_context, activity).each do |middleware|
	    p "Praktiz Logging: use " + middleware.name.to_s + " " + middleware.opts.to_s + " " + middleware.params.to_s 
	    use middleware.name, middleware.opts, middleware.params
	  end
	end
	@setup_middlewares.each do |setup_middleware|
	  @stack.insert_before 0, setup_middleware 
	end
	@stack.call
      end
    end
  end
  class Env 
    extend Mushin::Env

    class << self
      attr_accessor :id

      def get id
        Praktiz::Persistence::DS.load id.to_s + "praktiz"
      end

      def set id, &block 
	@id = id.to_s + "praktiz"
	def on domain_context, &block
	  @domain_context = domain_context 
	  @activities = []  
	  def activity statment 
	    @activities += [statment]  
	  end
	  instance_eval(&block)
	end
	instance_eval(&block)

	Dir["./praktiz/*"].each {|file| load file }  

	Praktiz::Engine.setup [Object.const_get('Praktiz::Persistence::DS')]
	@activities.each do |activity| 
	  Praktiz::Engine.run @domain_context, activity   
	end
	return Praktiz::Persistence::DS.load @id 
      end
    end
  end
end
