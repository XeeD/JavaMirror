# Controller zajišťující CRUD pro JAR soubory (model JarFile)
class JarFilesController < ApplicationController
  # Zobrazení výpisu všech nahraných souborů
  def index
    @jar_files = JarFile.all
  end

  # Zobrazení detailu souboru - data načte helper
  def show
  end

  # Formulář pro nahrání nového souboru - novou instanci vytváří automaticky
  # helper.
  def new
  end

  # Zobrazení formuláře pro editaci JAR souboru (možnost nahrát jiný JAR)
  def edit
  end

  # Create akce - vytoření vytvoření záznamu v databázi, nahrání souboru
  # Pokud se vše povede, ja uživatel přesměrován na detail nahraného
  # souboru. Pokud ne, tak se mu zobrazí formulář pro přidání znovu.
  def create
    if jar_file.save
      redirect_to jar_file, notice: 'JAR soubor byl v pořádku nahrán'
    else
      render action: "new"
    end
  end

  # Update akce - změna JAR souboru (nahrání nového)
  # Zatím nemá velký smysl, prože celý model JarFile obsahuje pouze jedno
  # podstatné pole - odkaz na nahraný soubor.
  def update
    if jar_file.update_attributes(params[:jar_file])
      redirect_to jar_file, notice: 'JAR soubor byl změněn'
    else
      render action: "edit"
    end
  end

  # Smazání JAR souboru
  # Po jeho smazání je uživatel přesměrován zpět na výpis všech JAR souborů
  def destroy
    jar_file.destroy

    redirect_to jar_files_url,
                notice: "JAR soubor byl smazán"
  end


  protected

  # Metoda buď načte JAR soubor z databáze, nebo vytvoření nové instance
  # Pokud není params[:id] prázdné, pokusíme se vyhledat záznam v DB podle tohoto ID
  # Jinak vytvoříme novou instanci s parametry z params[:jar_file] (mohou být i prázdné)
  def jar_file
    @jar_file ||= params[:id] ? JarFile.find(params[:id]) : JarFile.new(params[:jar_file])
  end

  # Z předchozí metody vyrobíme helper, který bude přístupný i ve view
  helper_method :jar_file
end
