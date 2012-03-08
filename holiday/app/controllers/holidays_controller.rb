class HolidaysController < ApplicationController
  def index
@holiday = Holiday.all
respond_to do |format|
format.html # Send the page using HTMLformat.xml { render :xml => @holidays } # Send the page using XML
format.atom
@holidays = Holiday.order("created_at").page(params[:page]).per(5)
end
end

  def show
login_required

@holiday = Holiday.find(params[:id])
  end

  def new
login_required
  @holiday = Holiday.new
  end

  def edit
  @holiday= Holiday.find(params[:id])
  end

  def update
  	@holiday = Holiday.find(params[:id])
if@holiday.save
  	@holiday.update_attributes(params[:holiday])
   	flash[:notice] = "Holiday updated!"
    	redirect_to @holiday
else
	flash[:error] = "Was not Updated!!"
  	redirect_to :action => "edit_holiday_path"
end

end

  def create
    @holiday = Holiday.create(params[:holiday])
    @holiday.user_id = current_user.id

if@holiday.save
  	@holiday.update_attributes(params[:holiday])
        flash[:notice] = " New Holiday Created!"
     	redirect_to @holiday
    else
      render :action => 'new'
	flash[:error] = "Was not Created!!"
end
  end

def destroy
  @holiday = Holiday.find(params[:id])
  @holiday.destroy
  redirect_to :action => "index"
end

end
