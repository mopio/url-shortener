require_relative 'helper'
require 'rack/test'
require 'server'

describe Server do
  include Rack::Test::Methods

  let(:app) { Server.new }
  let(:link) { Link.create(url: 'http://foo/?bar=baz') }

  before do
    Link.dataset.delete
  end

  it 'has a root' do
    get '/'
    last_response.must_be :ok?
  end

  it 'redirects' do
    get "/#{link.hashid}"
    follow_redirect!
    last_request.url.must_equal link.url
  end

  it 'handles bad hashids' do
    get '/bad'
    last_response.must_be :not_found?
  end

  it 'ignores favicon requests' do
    get '/favicon.ico'
    last_response.must_be :ok?
  end
end
