module ApplicationHelper
  # Devise isn't quite ready for twitter bootstrap. Here we convert the flash
  # messages keys to the types expected by Bootstrap 3.0.
  def flash_class(level)
    case level
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-error"
    when :alert then "alert alert-error"
    end
  end
  ###

  # Show login forms anywhere.
  # see: http://pupeno.com/2010/08/29/show-a-devise-log-in-form-in-another-page/
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  # confirmable, devise links partial
  def resource_class
    @devise_mapping.to ||= Devise.mappings[:user].to
  end
  ###

  def get_user_from_email(email)
    email.split(/@/)[0]
  end

  def kramdown(text)
    return sanitize Kramdown::Document.new(text, :auto_ids => false).to_html
  end
end
