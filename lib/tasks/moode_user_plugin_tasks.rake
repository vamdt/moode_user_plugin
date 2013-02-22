# desc "Initital admin user with default password"
# task :init_admin_user => :environment do
#   admin_user = MoodeUserPlugin::User.new(:username => "admin", :display_name => "admin", 
#     :password => "moodepass", :email => "admin@admin.com")
#   admin_user.admin = true
#   admin_user.save!
# end