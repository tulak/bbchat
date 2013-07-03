# Run with: rackup private_pub.ru -s thin -E production
require "bundler/setup"
require "yaml"
require "faye"
require "private_pub"
require 'pp'

Faye::WebSocket.load_adapter('thin')

PrivatePub.load_config(File.expand_path("../config/private_pub.yml", __FILE__), ENV["RAILS_ENV"] || "development")

class D
  def initialize app=nil
    @app = app
  end
  
  def call env
    
    unless @app.nil?
      r = @app.call(env)
    end
    
    # pp env
    
    r
  end
end

# use D
run PrivatePub.faye_app
# use PrivatePub.faye_app
