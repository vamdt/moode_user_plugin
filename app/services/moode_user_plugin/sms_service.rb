# encoding: UTF-8
module MoodeUserPlugin
  class SMSService
    require 'uri'

    def initialize(sms_server_config = {}, http_proxy)
      @sms_server_config = sms_server_config
      @http_proxy = http_proxy
    end

    def send_msg_to_phone(msg, phone)
      response = @http_proxy.get(sms_server_url, :query => query_parmas_to_send_sms(msg, phone))
      SMSResponse.new response.code, response.body, response.message, response.headers.inspect
    end

    private 

    def sms_server_url
      URI.join(@sms_server_config[:service_prefix], @sms_server_config[:send_uri]).to_s
    end

    def query_parmas_to_send_sms(msg, phone)
      {
        :CorpID => @sms_server_config[:corp_id],
        :Pwd => @sms_server_config[:pwd],
        :Mobile => phone,
        :Content => msg.encode("GB2312")
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
