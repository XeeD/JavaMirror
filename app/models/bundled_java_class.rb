# encoding: UTF-8

# Model představuje Java třídu, která je obsažena v některém
# z nahraných JAR souborů
#
# Jedná se o jednoduchou reprezentaci třídy, který obsahuje dostatek informací
# pro získání jejího class objectu, se kterým se dá pracovat dále.
class BundledJavaClass < ActiveRecord::Base
  # Odkaz na model JarFile
  belongs_to :jar_file

  # Validations
  validates :jar_file_id,
            presence: true

  # Scopes

  # Třídy, které jsou v určitém JAR souboru (pokud nemáme jeho instanci)
  scope :in_jar, ->(jar_file_id) { where(jar_file_id: jar_file_id) }

  # Třídy, které mají dané kanonické jméno (v rámci JAR souboru bude vždy jen jedna)
  scope :with_canonical_name, ->(canonical_name) { where(canonical_name: canonical_name) }

  # Instance třídy ClassReflector, která nám poskytuje informace o Java clas objectu
  def class_reflector
    @class_reflector ||= ClassReflector.from_bundled_java_class(self)
  end

  # Načtení JAR souboru do paměti (require), abychom mohli získavat class
  # objecty.
  def require_jar
    jar_file.require_jar
  end
end
