require_relative '../phase5/controller_base'

module Phase6
  class ControllerBase < Phase5::ControllerBase
    # use this with the router to call action_name (:index, :show, :create...)
    def invoke_action(action_name)
      if self.already_built_response?
        self.render(action_name)
      else
        self.send(action_name)
      end
    end
  end
end


# c = CatController.new(req, res)
# c.index
