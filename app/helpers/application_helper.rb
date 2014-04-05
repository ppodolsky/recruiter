module ApplicationHelper
  # slim compiles markdown before the page is requested, so to store and render
  # markdown content from the database, we need to write our own processor
  def markdown_to_html(text)
    Kramdown::Document.new(text).to_html.html_safe
  end
  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end

  def field_class(resource, field_name)
    if resource.errors[field_name]
      return "error".html_safe
    else
      return "".html_safe
    end
  end

  # Devise isn't quite ready for twitter bootstrap. Here we convert the flash
  # messages keys to the types expected by Bootstrap 3.0.
  def flash_class(level)
    case level
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-danger"
    when :alert then "alert alert-danger"
    end
  end
  ###

  # Highlight navigation link of current page
  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'active' : nil

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end
  ###
  def custom_range
    {
      "birth_year" => (Time.now.year - 80..Time.now.year - 14),
      "years_resident" => (1..10),
      "year_started" => ((Time.now.year.to_i - 10)..(Time.now.year.to_i)),
      "current_gpa" => (0..4),
      "attendance" => (0..100)
    }
  end
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
end
