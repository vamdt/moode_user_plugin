require "moode_user_plugin/engine"
require "haml"
require "bootstrap-sass"
require "httparty"

module MoodeUserPlugin
  mattr_accessor :sms_server_config
end
