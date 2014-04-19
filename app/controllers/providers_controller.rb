class ProvidersController < ApplicationController
  def show
    @provider = Provider.find_by npi: params[:id]
  end
  
  def payment_by_specialty
    @specialty = Specialty.find_by(id: params[:specialty])
    
    if params[:state]
      @providers = Provider.where("specialty = ? and state=?", @specialty.name, params[:state]).order("total_pmt desc").limit(20);
    else
      @providers = Provider.where("specialty = ?", @specialty.name).order("total_pmt desc").limit(20);
    end
    
   
    respond_to do |format|
      format.html  # payment_by_specialty.html.erb
      format.json  { render :json => @providers.to_json() }
    end
  end
  
  def payment
    if params[:state]
      @providers = Provider.where("state=?", params[:state]).order("total_pmt desc").limit(20);
    else
      @providers = Provider.order("total_pmt desc").limit(20);
    end
    
    respond_to do |format|
      format.html  { render action:"payment_by_specialty"}
      format.json  { render :json => @providers.to_json() }
    end
  end

  def by_proc_frequency
  end
end
