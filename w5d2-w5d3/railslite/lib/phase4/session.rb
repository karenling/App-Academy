require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      @cookie = req.cookies.find do |cookie|
        cookie.name == '_rails_lite_app'
      end

      if @cookie.nil?
        @session = {}
      else
        @session = JSON.parse(@cookie.value)
      end
      #@cookies=[#<WEBrick::Cookie:0x007ff23486a3e8 @name="_rails_lite_app", @value="{\"xyz\":\"abc\"}"
    end

    def [](key)
      @session[key]
    end

    def []=(key, val)
      @session[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      res.cookies << WEBrick::Cookie.new('_rails_lite_app', @session.to_json)
    end
  end
end
