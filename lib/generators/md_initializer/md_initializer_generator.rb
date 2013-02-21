class MdInitializerGenerator < Rails::Generators::Base
  
  desc "Mount moode user plugin to app root"
  def mount_plugin_to_root
    route("mount MoodeUserPlugin::Engine, :at => '/'")
  end

  desc "Extract migrations"
  def extract_migration
    rake "moode_user_plugin:install:migrations"
  end

  desc "Run db migrate"
  def migrate
    rake "db:migrate"
  end

end

