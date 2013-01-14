# Tento jednoduchý controller vyhledá pouze vyhledá dle ID
# instanci třídy BundledJavaClass a zobrazí ji
class BundledJavaClassesController < ApplicationController
  # Zobrazení detailu třídy
  def show
    @bundled_java_class = BundledJavaClass.find(params[:id])
  end
end
