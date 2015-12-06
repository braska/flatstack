module DeviseHelper
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
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
