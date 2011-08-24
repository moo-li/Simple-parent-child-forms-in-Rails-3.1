class KidsController < ApplicationController
  def create
    @mom = Mom.find(params[:mom_id])
    @kid = @mom.kids.create(params[:kid])
    redirect_to mom_path(@mom)
  end

  def destroy
    @mom = Mom.find(params[:mom_id])
    @kid = @mom.kids.find(params[:id])
    @kid.destroy
    redirect_to mom_path(@mom)
  end
end
