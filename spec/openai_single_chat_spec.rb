require 'spec_helper'
require 'openai_single_chat'

RSpec.describe OpenaiSingleChat::Client do
  let(:api_key) { 'dummy_api_key' }
  let(:client) { described_class.new }

  before do
    allow(ENV).to receive(:[]).with('OPENAI_API').and_return(api_key)
  end

  describe '#chat' do
    let(:message) { "こんにちは, AI" }
    let(:response_body) do
      {
        choices: [
          {
            message: {
              content: "こんにちは、どうかしましたか"
            }
          }
        ]
      }.to_json
    end

    before do
      stub_request(:post, "https://api.openai.com/v1/chat/completions")
        .with(
          body: {
            model: "gpt-4o-mini",
            messages: [{ role: "user", content: message }]
          }.to_json,
          headers: {
            'Content-Type' => 'application/json',
            'Authorization' => "Bearer #{api_key}"
          }
        )
        .to_return(status: 200, body: response_body, headers: { 'Content-Type' => 'application/json' })
    end

    it 'returns the AI response' do
      expect(client.chat(message)).to eq("こんにちは、どうかしましたか")
    end
  end

  context 'when API returns an error' do
    let(:error_response) do
      {
        error: {
          message: "Invalid API key"
        }
      }.to_json
    end

    before do
      stub_request(:post, "https://api.openai.com/v1/chat/completions")
        .to_return(status: 401, body: error_response, headers: { 'Content-Type' => 'application/json' })
    end

    it 'raises an OpenaiSingleChat::Error' do
      expect { client.chat("こんにちは") }.to raise_error(OpenaiSingleChat::Error, "OpenAI API Error: Invalid API key")
    end
  end
end