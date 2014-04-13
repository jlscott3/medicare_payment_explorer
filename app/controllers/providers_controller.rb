class ProvidersController < ApplicationController
  def show
    @provider = Provider.find_by npi: params[:id]
  end
  
  def payment_by_specialty
    # @sums = Providers.order("total_pmt_amt").limit(20);
    
    if params[:state]
      @providers = Provider.where("specialty = ? and state=?", params[:specialty], params[:state]).order("total_pmt desc").limit(20);
    else
      @providers = Provider.where("specialty = ?", params[:specialty]).order("total_pmt desc").limit(20);
    end
    # 
   
    respond_to do |format|
      format.html  # index.html.erb
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
