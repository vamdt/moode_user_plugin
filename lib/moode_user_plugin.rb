require "moode_user_plugin/engine"
require "haml"
require "bootstrap-sass"
require "httparty"

module MoodeUserPlugin
  mattr_accessor :sms_server_config
  mattr_accessor :verify_code_message_template
  mattr_accessor :need_verify_code
end
