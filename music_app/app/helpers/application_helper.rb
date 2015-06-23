module ApplicationHelper
 include ERB::Util

 def ugly_lyrics(lyrics)
   start = "&#9835;"

   lyrics = lyrics.split("\r").join("|").gsub("\n", "").split("|")
   lyrics = lyrics.map do |line|
     if line.empty?
        line + "<br>"
     else
       "<pre>#{start} " + h(line) + "</pre>"
     end
   end
   lyrics = lyrics.join

   lyrics.html_safe
 end

 def form_authentication
   html = <<-HTML
   <input type="hidden"
          name="authenticity_token"
          value="#{form_authenticity_token}">
   HTML

   html.html_safe
end
end
