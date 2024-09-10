require 'openai_single_chat'

client = OpenaiSingleChat::Client.new
response = client.chat("こんにちは、AIアシスタント")
puts response

# モデルを指定する場合
custom_client = OpenaiSingleChat::Client.new('gpt-4')
custom_response = custom_client.chat("日本で一番高い山は？")
puts custom_response