# encoding: UTF-8
module MoodeUserPlugin
  class SMSService
    require 'uri'

    def self.sms_server_config_map 
      {
        :corp_id => 'ZLJK00145',
        :pwd => '123456',
        :service_prefix => 'http://U.wangxun360.com',
        :send_uri => '/WS/Send.aspx'
      }
    end

    def self.send_msg_to_phone(msg, phone)
      response = HTTParty.get(sms_server_url, :query => query_parmas_to_send_sms(msg, phone))
      SMSResponse.new response.code, response.body, response.message, response.headers.inspect
    end

    private 

    def self.sms_server_url
      URI.join(sms_server_config_map[:service_prefix], sms_server_config_map[:send_uri]).to_s
    end

    def self.query_parmas_to_send_sms(msg, phone)
      {
        :CorpID => sms_server_config_map[:corp_id],
        :Pwd => sms_server_config_map[:pwd],
        :Mobile => phone,
        :Content => msg
      }
    end

  end

  class SMSResponse

    def initialize(code, body, message, headers)
      @code, @body, @message, @headers = code, body, message, headers
      log_response
    end

    def ok
      @body.to_i == 0
    end

    def error
      sms_response_code_map[@body.to_i.to_s]
    end

    def sms_response_code_map
      {
        '0' => '发送成功',
        '-1' => '账号未注册',
        '-2' => '其他错误',
        '-3' => '密码错误',
        '-4' => '手机号格式不对',
        '-5' => '余额不足',
        '-6' => '定时发送时间不是有效的时间格式',
        '-7' => '禁止10小时以内向同一手机号发送相同短信',
        '-100' => '限制此IP访问',
        '-101' => '调用接口速度太快'
      }
    end

    def log_response
      puts "--------sms response:", "code=#{@code}", "body=#{@body}", "message=#{@message}", "headers=#{@headers}"
      puts "--------send sms error:", sms_response_code_map[@body.to_i.to_s]
    end
  end
end
