module DeviseHelper
  # -----------------------------------------------------
  def devise_error_messages!
    return "" unless devise_error_messages?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    
    html = <<-HTML
      <div class="errors">
				<h4>Please correct the following issues and resubmit</h4>
				<ul>#{messages}</ul>
      </div>
    HTML
    
    html.html_safe
  end
  
  # -----------------------------------------------------
  def devise_error_messages?
    !resource.errors.empty?
  end
end