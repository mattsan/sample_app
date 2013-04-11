module UsersHelper
  def gravatar_for(user, options=nil)
  	gravatar_id  = Digest::MD5::hexdigest(user.email.downcase)
  	gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
  	if options.nil?
	  image_tag(gravatar_url, alt: user.name, class: "gravatar")
	else
	  image_tag(gravatar_url, alt: user.name, width: options[:size], height: options[:size], class: "gravatar")
	end
  end
end
