# Helpery pro view controlleru BundledJavaClassController
module BundledJavaClassesHelper
  # Zobrazení výpisu některé vlastnosti Java class objectu
  # Spoléháme se na to, že nám controller zapsal do instanční proměnné
  # @bundled_java_class instanci modelu BundledJavaClass
  # Z této instance používáme metodu class_reflector, která
  # vrací instanci ClassReflector - to je adaptér mezi JavaClass (třída JRuby)
  # naším view. Viz dokumentace ClassReflector
  #
  # === Parametry
  #
  #   <tt>feature</tt>: kterou metodu ClassReflectoru budeme používat
  #   <tt>title</tt>: zobrazený popisek
  #   <tt>features</tt>: [nepovinné] seznam již získaných vlastností, pokud nechceme
  #                        přímo volat metodu na reflectoru
  def feature_list(feature, title, features = nil)
    # Můžeme seznam "features" prředat jako parametr
    if features.nil?
      features = @bundled_java_class.class_reflector.send(feature)
    end

    # Pokud není seznam nil nebo prázdný
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

  # Vypsání rozhraní dané třídy společně s odkazy na jejich "dokumentaci"
  def interfaces_with_links
    @bundled_java_class.class_reflector.interfaces.map do |interface|
      link_to_class(interface.to_s)
    end
  end

  # Odkaz na detail třídy (pokud se jedná o třídu z daného JAR souboru)
  # Jinak se zobrazí pouze název třídy, který není obalen odkazem.
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
