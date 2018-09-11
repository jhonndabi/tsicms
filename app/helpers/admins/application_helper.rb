module Admins::ApplicationHelper
  def image_tag_preview(model, options = {})
    model_image_attribute = options[:model_image_attribute] || 'image'
    image_class = options[:class] || 'file_preview active'
    image_default = options[:image_default] || 'logo-tsi-text.png'
    image_model = model.send(model_image_attribute.to_sym)
    image_path = image_model.attached? ? image_model : image_default

    image_tag image_path, class: image_class
  end
end