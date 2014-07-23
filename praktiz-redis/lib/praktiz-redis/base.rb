require "redis"

module Praktiz 
  module Persistence
    class DS 

      Praktiz::Env.register do 
	attr_accessor :id
      end

      @@redis = Redis.new

      def initialize app
	@app = app
	@id = Praktiz::Env.id
      end

      def call(env)
	p "Praktiz::Persistence::DS instance id = " + @id.to_s 
	if exists? @id 
	  env[:praktiz] = DS.load @id 
	  p 'resotred' + env[:praktiz].to_s
	else 
	  p 'new obj from Praktiz::Env class'
	  env[:praktiz] = Praktiz::Env.new
	  env[:praktiz].id  = @id
	  p "env[:praktiz].id equals " +  env[:praktiz].id.to_s
	end
	@app.call(env)
	DS.store env[:praktiz] 
	p "stored " + env[:praktiz].to_s 
      end

      def DS.store obj
	begin
	  @praktiz_env = Marshal.dump obj 
	  @@redis.set(obj.id, @praktiz_env)
	ensure
	  p "storing praktiz Env " + obj.to_s
	end
      end
      def DS.load id
	return Marshal.load (@@redis.get(id))
      end

      def exists? id
	if (@@redis.get id) && (Marshal.load @@redis.get id) 
	  p "Praktiz::Persistence::DS.exists? true" 
	  return true
	else 
	  p "Praktiz::Persistence::DS.exists? false" 
	  return false
	end
      end
    end
  end
end
