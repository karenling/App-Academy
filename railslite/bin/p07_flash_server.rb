require 'webrick'
require_relative '../lib/phase7/controller_base'
require_relative '../lib/phase7/flash'
# require_relative '../lib/phase6/controller_base'

# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html

class MyController < Phase7::ControllerBase
  def go
    flash["notice"] = "Ordinary flash"

    render_content(flash["notice"], "text/html")


    # (flash.now)["errors"] = "This is a flash.now errors"
    #
    # render_content(flash["errors"], "text/html")


    # flash["notice"] = "Hello this is a flash notice" # we're setting flash["notice"] here

    # puts flash.now.class
    # puts flash.class
    # redirect_to :stay
    # so if we did a redirect_to stay

  end

  def stay
    # render :counting_show
    render_content(flash["errors"], "text/html")
  end
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  if req.path == "/go"
    MyController.new(req, res).go
  else
    MyController.new(req, res).stay
  end
end

trap('INT') { server.shutdown }
server.start
