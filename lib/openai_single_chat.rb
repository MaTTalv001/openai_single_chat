# frozen_string_literal: true

require_relative "openai_single_chat/version"
require 'httparty'
require 'json'

module OpenaiSingleChat
  class Error < StandardError; end

  class Client
    include HTTParty
    base_uri 'https://api.openai.com/v1'
    format :json

    def initialize(model = 'gpt-4o-mini')
      @model = model
      @options = {
        headers: {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{ENV['OPENAI_API']}"
        }
      }
    end

    def chat(message, system_message = nil)
      messages = []
      messages << { role: 'system', content: system_message } if system_message
      messages << { role: 'user', content: message }

      body = {
        model: @model,
        messages: messages
      }.to_json

      response = self.class.post('/chat/completions', body: body, headers: @options[:headers])
      
      if response.success?
        response.parsed_response['choices'][0]['message']['content']
      else
        handle_error_response(response)
      end
    end

    private

    def handle_error_response(response)
      error_message = response.parsed_response['error']['message'] rescue '不明なエラーが発生しました'
      raise Error, "OpenAI API Error: #{error_message}"
    end
  end
end