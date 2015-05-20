module ApplicationHelper
  def voting(working_instance)
    if working_instance.is_a?(Comment)
      up_url = comment_upvote_url(working_instance.id)
      down_url = comment_downvote_url(working_instance.id)
    else
      up_url = post_upvote_url(working_instance.id)
      down_url = post_downvote_url(working_instance.id)
    end

    vote_value = (working_instance.vote_value.to_s)

    if vote_value.empty?
      vote_value = "0"
    end


    down_button = button_to "-1", down_url, method: "post"

    up_button = button_to "+1", up_url, method: "post"

    (vote_value + " votes " + down_button + " " + up_button).html_safe
  end

  def csrf_tag
    html = <<-HTML
      <input type="hidden"
             name="authenticity_token" value="#{form_authenticity_token}">
    HTML

    html.html_safe
  end


end
