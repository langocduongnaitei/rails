module UsersHelper
  def gravatar_for user, size: Settings.user.ava_size
    gravatar_id = Digest::MD5.hexdigest user.email.downcase
    gravatar_url = t "users.helpers.link_image", gravatar_id: gravatar_id
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end
end
