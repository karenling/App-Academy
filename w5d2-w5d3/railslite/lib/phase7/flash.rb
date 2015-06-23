require 'json'
require 'webrick'

module Phase7
  class Flash
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      @cookie = req.cookies.find do |cookie|
        cookie.name == '_rails_lite_flash'
      end


      if @cookie.nil? # if the cookie is empty
        @flash_now = {} # we'll just set the flash_now to empty because there is nothing to pass
      else
        @flash_now = JSON.parse(@cookie.value) # we always want to put anything in our cookie:flash into flash_now
      end

      @f = {} # set the flash to empty because it shouldn't persist after we make a request


      # JSON.parse(@cookie.value).each do |key, value|
      #   @flash_now[key] = value
      # end
      #@cookies=[#<WEBrick::Cookie:0x007ff23486a3e8 @name="_rails_lite_app", @value="{\"xyz\":\"abc\"}"
    end

    def now
      @flash_now
    end

    def [](key)
      @flash_now[key]
    end

    def []=(key, val)
      @f[key] = val # we're always setting the @flash.
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_flash(res)
      res.cookies << WEBrick::Cookie.new('_rails_lite_flash', @f.to_json)
    end
  end
end
