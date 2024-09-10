# OpenAI Single Chat

OpenAI Single Chat is a Ruby gem that provides a simple interface to interact with OpenAI's chat API. It allows you to easily integrate AI-powered chat functionality into your Ruby applications.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'openai_single_chat'
```

And then execute:

```bash
bundle install
```

## Configuration

Set your OpenAI API key as an environment variable:
```bash
export OPENAI_API=your_openai_api_key_here
```

For Rails applications, you can use the dotenv gem and add your API key to a `.env` file:

```
OPENAI_API=your_openai_api_key_here
```

## Usage

Here's a basic example of how to use the OpenAI Single Chat gem:

```ruby
require 'openai_single_chat'

client = OpenaiSingleChat::Client.new
response = client.chat("Hello, AI!")
puts response
```

## Specifying a model

You can specify a different OpenAI model when initializing the client:

```
client = OpenaiSingleChat::Client.new('gpt-4o')
```
If no model is specified, it defaults to 'gpt-4o-mini'.
```
client = OpenaiSingleChat::Client.new
# Uses 'gpt-4o-mini' as the default model
```

## Rails Integration

To use OpenAI Single Chat in a Rails application:
1. Add the gem to your Gemfile and run bundle install.
2. Create a controller action:

```ruby
class ChatController < ApplicationController
  def index
    if params[:message]
      client = OpenaiSingleChat::Client.new
      @response = client.chat(params[:message])
    end
  end
end
```
3. Create a view:
```erb
<h1>Chat with AI</h1>

<%= form_with url: chat_index_path, method: :get, local: true do |f| %>
  <%= f.text_field :message, placeholder: 'Enter your message' %>
  <%= f.submit 'Send' %>
<% end %>

<% if @response %>
  <h2>AI Response:</h2>
  <p><%= @response %></p>
<% end %>
```
## License
The gem is available as open source under the terms of the MIT License.