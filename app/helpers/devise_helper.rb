module DeviseHelper

  # Deviseのdevise_error_messages!をオーバーライド
  def devise_error_messages!
    return "" if resource.errors.empty?

    html = ""
    resource.errors.full_messages.each do |errmsg|
      html += <<-EOF
      <div class="alert alert-danger">#{errmsg}</div>
      EOF
    end
    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end
end