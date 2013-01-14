# Všechny ostatní controllery v aplikaci jsou potomkem této třídy
# Zde se nastavují globální filtry (třeba přihlášení) atd.
class ApplicationController < ActionController::Base
  protect_from_forgery
end
