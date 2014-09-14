# coding: UTF-8

require 'mscorlib'
load_assembly 'System.Web'
include System
include System::Net
include System::Web

class ShrimpPlugin

	def initialize()
	end

	def OnInitialize( plugin )
		plugin.PluginName = "RecoTwReg";
		plugin.PluginDeveloper = "UlickNormanOwen"
		plugin.PluginVersion = 100
		plugin.PluginDescription = "選択したツイートをRecoTw(黒歴史保存サービス)に送信します"
		
	end
	
	def OnCreateTweetMenu ( hook )
		hook.OnClickedMenu = Proc.new() { |data|
			PluginModule::http_request(data.status.DynamicTweet.id)
		}
		hook.text = "このツイートを黒歴史登録する"
	end
end

class PluginModule
	def self.http_request(id)
		url = "http://recotw.tk/api/tweet/record_tweet";
		
		postData = "id="+ id.to_s
		postDataBytes = postData.ToByteArray()

		begin
			req = System::Net::WebRequest.Create(url)
			req.Method = "POST"
			req.ContentType = "application/x-www-form-urlencoded"
			req.ContentLength = postDataBytes.length
			
			reqStream = req.GetRequestStream()
			reqStream.Write(postDataBytes, 0, postDataBytes.length)
			reqStream.Close()
		rescue
			#エラー
		end
	end
end
