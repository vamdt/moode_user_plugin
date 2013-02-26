module MoodeUserPlugin
  class Engine < ::Rails::Engine
    isolate_namespace MoodeUserPlugin

    config.autoload_paths << File.expand_path("../../app/services", __FILE__)

    config.generators do |g|
      g.template_engine :haml
    end

  end
end
