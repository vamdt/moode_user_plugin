class MdInitializerGenerator < Rails::Generators::Base
  
  desc "Mount moode user plugin to app root"
  def mount_plugin_to_root
    route("mount MoodeUserPlugin::Engine, :at => '/'")
  end

end

