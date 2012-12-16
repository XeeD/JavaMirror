class JarFilesController < ApplicationController
  # GET /jar_files
  # GET /jar_files.json
  def index
    @jar_files = JarFile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jar_files }
    end
  end

  # GET /jar_files/1
  # GET /jar_files/1.json
  def show
    @jar_file = JarFile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @jar_file }
    end
  end

  # GET /jar_files/new
  # GET /jar_files/new.json
  def new
    @jar_file = JarFile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @jar_file }
    end
  end

  # GET /jar_files/1/edit
  def edit
    @jar_file = JarFile.find(params[:id])
  end

  # POST /jar_files
  # POST /jar_files.json
  def create
    @jar_file = JarFile.new
    @jar_file.data = params[:jar_file][:data]

    respond_to do |format|
      if @jar_file.save
        format.html { redirect_to @jar_file, notice: 'Jar file was successfully created.' }
        format.json { render json: @jar_file, status: :created, location: @jar_file }
      else
        format.html { render action: "new" }
        format.json { render json: @jar_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /jar_files/1
  # PUT /jar_files/1.json
  def update
    @jar_file = JarFile.find(params[:id])

    respond_to do |format|
      if @jar_file.update_attributes(params[:jar_file])
        format.html { redirect_to @jar_file, notice: 'Jar file was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @jar_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jar_files/1
  # DELETE /jar_files/1.json
  def destroy
    @jar_file = JarFile.find(params[:id])
    @jar_file.destroy

    respond_to do |format|
      format.html { redirect_to jar_files_url }
      format.json { head :no_content }
    end
  end
end
