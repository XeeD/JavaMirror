module BundledJavaClassesHelper
  def feature_list(feature, title, features = nil)
    if features.nil?
      features = @bundled_java_class.class_reflector.send(feature)
    end

    if features.present?
      heading = content_tag :h3, title
      list = content_tag :ul do
        list_items = ""
        features.map do |field|
          list_items << content_tag(:li, field)
        end
        list_items.html_safe
      end

      heading + list
    end
  end

  def interfaces_with_links
    @bundled_java_class.class_reflector.interfaces.map do |interface|
      link_to_class(interface.to_s)
    end
  end

  def link_to_class(class_name)
    klass = BundledJavaClass.
        in_jar(@bundled_java_class.jar_file_id).
        with_canonical_name(class_name).
        first

    if klass
      link_to class_name, klass
    else
      class_name
    end
  end
end