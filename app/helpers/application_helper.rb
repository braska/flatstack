module ApplicationHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = {
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        lax_html_blocks: true,
        strikethrough: true,
        superscript: true,
        space_after_headers: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  def title(title)
    content_for :title, title.to_s
  end

  def bootstrap_class_for flash_type
    puts flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      if message.kind_of?(Array)
        message.each do |m|
          concat(content_tag(:div, m, class: "alert #{bootstrap_class_for(msg_type)}") do
            concat m
          end)
        end
      else
        concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)}") do
          concat message
        end)
      end
    end
    nil
  end

  def admin_zone?
    controller.class.name.split("::").first=="Admin"
  end
end
