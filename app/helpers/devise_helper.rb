module DeviseHelper
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)}") do
        # concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
        concat message
      end)
    end
    nil
  end

  def devise_error_messages!
    resource.errors.full_messages.each do |msg|
      concat(content_tag(:div, msg, class: "alert alert-danger") do
        concat msg
      end)
    end
    nil
  end
end
