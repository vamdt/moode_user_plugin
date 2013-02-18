module MoodeUserPlugin
  class Engine < ::Rails::Engine
    isolate_namespace MoodeUserPlugin

    config.generators do |g|
      g.template_engine :haml
    end

  end
end
