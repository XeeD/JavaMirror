# encoding: UTF-8

# Tato třída je reprezentací class souboru, který je uložen
# v nahraném JAR souboru.
#
# Hlavní funkcionalita
# Umí vytvořit novou instanci třídy z Javy.

class ClassInJar

  # Veřejné atributy
  # name: jméno třídy (i s případnými $ znaky, označujícími vnořené třídy)
  # location_in_jar: cesta k třídě uvnitř JAR souboru
  attr_reader :name, :location_in_jar

  # Vytvoření nové instance - stačí nám znát umístění třídy v balíčku,
  # zbytek informací si odvodíme díky konvencím.
  def initialize(location_in_jar)
    match_data = location_in_jar.match /(?:(.+)\/)?([^\/]+)\.class$/
    if match_data
      @package_path = match_data[1]
      @name = match_data[2]
      @location_in_jar = location_in_jar
    end
  end

  # Vytvoří novou Java třídu (class object). JAR soubor již
  # předtím musí být načten.
  # Třída se načítá vždy pouze jednou, poté je uložena
  # v instance variable pro další použití.
  def constantize
    unless @klass
      @klass = eval "Java.#{canonical_name}"
    end

    @klass
  end

  # Metoda zavolá ClassInJar#constantize a vrací nil
  def preload
    constantize
    nil
  end

  # Složí jméno třídy společně s jmény balíčků, ve kterých je
  # do "tečkové notace", například java.lang.String
  def canonical_name
    split_canonical_name.join(".")
  end

  # Vrací cestu k třídě v rámci balíčků (bez jména třídy) v
  # "tečkové notaci"
  def package_name
    split_package.present? ? split_package.join(".") : nil
  end

  # Vrací pole se seřazenými jmény balíčků (cesta k třídě)
  def split_package
    (@package_path && @package_path.split("/")) || []
  end

  # Vrací pole s řetězců: cesta k třídě (balíčky) a jméno třídy
  def split_canonical_name
    split_package + split_class_name
  end

  # Jméno třídy jako pole řetězců.
  # Vnořené třídy jsou odděleny ve jméně class souboru pomocí <code>$</code>
  def split_class_name
    name.split("$")
  end

  # Reprezentace třídy jako hash - hodí se například
  # pro uložení třídy do databáze, abychom nemuseli načítat a prohledávat
  # celý JAR soubor, pokud chceme zobrazit seznam tříd, které v něm jsou.
  def to_hash
    {
        name: name.to_s,
        package: package_name,
        canonical_name: canonical_name,
        location_in_jar: location_in_jar
    }
  end
end
