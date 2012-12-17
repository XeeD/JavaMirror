class BundledJavaClassesController < ApplicationController
  def show
    @bundled_java_class = BundledJavaClass.find(params[:id])
  end
end
