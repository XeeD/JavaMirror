class JarFilesController < ApplicationController
  def index
    @jar_files = JarFile.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if jar_file.save
      redirect_to jar_file, notice: 'Jar file was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if jar_file.update_attributes(params[:jar_file])
      redirect_to jar_file, notice: 'Jar file was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    jar_file.destroy

    redirect_to jar_files_url
  end


  protected

  def jar_file
    @jar_file ||= params[:id] ? JarFile.find(params[:id]) : JarFile.new(params[:jar_file])
  end

  helper_method :jar_file
end
