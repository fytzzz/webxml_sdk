# Wearher
#WebXml.com.cn 2400多个城市天气预报Web服务，包含2300个以上中国城市和100个以上国外城市天气预报数据。数据每2.5小时左右自动更新一次，准确可靠。
#使用本站 WEB 服务请注明或链接本站：http://www.webxml.com.cn/ 感谢大家的支持！
module Webxml
  class Weather < Base
    class << self
      @@web_server_url = 'http://webservice.webxml.com.cn/WebServices/WeatherWS.asmx'
      @@avaliable_menthods = %w(getRegionCountry getRegionDataset getRegionProvince getSupportCityDataset getSupportCityString getWeather)

      def method_missing(method_name, *args, &block)
        options = args.extract_options!.symbolize_keys!
        options.reverse_merge!(:theUserID => theUserID) if method_name.to_s == "getWeather"
        self.get_weather_services(method_name.to_s, options, &block)
      end
    end
  end
end