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

After setting up your `.env` file, you may need to take additional steps to ensure the environment variables are loaded:

- If you're using Docker, you might need to rebuild your container:
  ```bash
  docker-compose build
  docker-compose up
  ```
- For local development, you may need to restart your Rails server.

Make sure your application is configured to load the `.env` file, typically in your `config/application.rb` or `config/environments/development.rb`.

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

```ruby
client = OpenaiSingleChat::Client.new('gpt-4o')
```
If no model is specified, it defaults to 'gpt-4o-mini'.
```ruby
client = OpenaiSingleChat::Client.new
# Uses 'gpt-4o-mini' as the default model
```

## Rails Integration

To use OpenAI Single Chat in a Rails application:
1. Add the gem to your Gemfile and run bundle install.
2. Create a controller action in `app/controllers/chat_controller.rb`:

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
3. Create a view in `app/views/chat/index.html.erb`:
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
4. Add the following routes to your `config/routes.rb`:
```ruby
Rails.application.routes.draw do
  root 'chat#index'
  get 'chat/index'
  # ... other routes ...
end
```

## License
The gem is available as open source under the terms of the MIT License.