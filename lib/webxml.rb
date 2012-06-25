# WEBXML
#使用本站 WEB 服务请注明或链接本站：http://www.webxml.com.cn/
require "net/http"
require "uri"
module Webxml
  class Base
    cattr_accessor :web_server_url, :avaliable_menthods, :options,:theUserID
    @@theUserID = '3d5faa159e694fbba33f0f7ab40c0134'
    class HttpRequestError < StandardError
    end
    class MethodNameNotFound < StandardError
    end
    class << self
      def get_weather_services(method_name, options={})
        raise MethodNameNotFound, "method_name is not avaliable." unless  avaliable_menthods.include?(method_name)
        method = options.delete(:method)||(options.blank? ? 'get' : 'post')
        req_data = escape_values(options)
        url = "#{web_server_url}/#{method_name}"

        resp = if method == 'post'
                 #Posts HTML form data to the URL. Form data must be represented as a Hash of String to String
                 Net::HTTP.post_form(URI.parse(url), req_data||{})
               else
                 #Sends a GET request to the path and gets a response, as an HTTPResponse object.
                 url = URI.parse([url, req_data.to_query].join("?"))
                 req = Net::HTTP::Get.new("#{url.path}?#{url.query}")
                 Net::HTTP.start(url.host, url.port) { |http|
                   http.request(req)
                 }
               end
        if resp.code_type != Net::HTTPOK
          raise HttpRequestError, resp.message
        end
        block_given? ? yield(resp.body) : resp.body
      end
    end

    private
    def self.escape_values(options={})
      new_options = Hash.new
      options.each do |k, v|
        #TODO ...
        new_options[k.to_s] = v if v.is_a?(String)
      end
      new_options
    end
  end
end