require_relative '../phase6/controller_base'
require_relative './flash'

module Phase7
  class ControllerBase < Phase6::ControllerBase
    def redirect_to(url)
      super
      flash.store_flash(@res)
    end

    def render_content(content, content_type)
      super
      flash.store_flash(@res)
    end

    # method exposing a `Flash` object
    def flash
      @flash ||= Flash.new(@req)
    end
  end
end
