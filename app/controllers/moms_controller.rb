class MomsController < ApplicationController
  # GET /moms
  # GET /moms.json
  def index
    @moms = Mom.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @moms }
    end
  end

  # GET /moms/1
  # GET /moms/1.json
  def show
    @mom = Mom.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mom }
    end
  end

  # GET /moms/new
  # GET /moms/new.json
  def new
    @mom = Mom.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mom }
    end
  end

  # GET /moms/1/edit
  def edit
    @mom = Mom.find(params[:id])
  end

  # POST /moms
  # POST /moms.json
  def create
    @mom = Mom.new(params[:mom])

    respond_to do |format|
      if @mom.save
        format.html { redirect_to @mom, notice: 'Mom was successfully created.' }
        format.json { render json: @mom, status: :created, location: @mom }
      else
        format.html { render action: "new" }
        format.json { render json: @mom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /moms/1
  # PUT /moms/1.json
  def update
    @mom = Mom.find(params[:id])

    respond_to do |format|
      if @mom.update_attributes(params[:mom])
        format.html { redirect_to @mom, notice: 'Mom was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @mom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moms/1
  # DELETE /moms/1.json
  def destroy
    @mom = Mom.find(params[:id])
    @mom.destroy

    respond_to do |format|
      format.html { redirect_to moms_url }
      format.json { head :ok }
    end
  end
end
