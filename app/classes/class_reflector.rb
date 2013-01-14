# Adaptér mezi Java class objectem a naším Ruby světem.
# Slouží především pro zjednodušení přístupu k metodám,
# které nám definuje JRuby, ale neposkytují přesně takové informace,
# které potřebujeme.
class ClassReflector

  # Konstruktor požaduje jako parametr reprezentaci Java třídy z JRuby,
  # nad kterým budeme provádět reflexi.
  def initialize(klass)
    @klass = klass
  end

  # Vrací Java class
  def java_class
    @klass.java_class
  end

  # Deklarované (ne zděděné) instanční metody
  def instance_methods
    java_class.declared_instance_methods
  end

  # Zděděné instanční metody
  def inherited_instance_methods
    java_class.java_instance_methods - instance_methods
  end

  # Deklarované třídní metody
  def class_methods
    java_class.declared_class_methods
  end

  # Zděděné třídní meotdy
  def inherited_class_methods
    java_class.java_class_methods - class_methods
  end

   # Deklarované vnořené třídy
  def inner_classes
    java_class.declared_classes.map { |klass| klass.to_s.gsub(/^.+\$/, "") }
  end

  # Class methods

  # Vytovření nové instance z modelu třídy - instance BundlelJavaClass
  # Předtím musíme načíst JAR soubor a načíst class object
  def self.from_bundled_java_class(bundled_java_class)
    bundled_java_class.require_jar
    klass = eval "Java.#{bundled_java_class.canonical_name}"
    new(klass)
  end

  # "Fuzzy proxy" - všechny ostatní metody "přeposíláme" na Java class object,
  # nad kterým provádíme reflexi.
  def method_missing(*params)
    java_class.send(*params)
  end
end
