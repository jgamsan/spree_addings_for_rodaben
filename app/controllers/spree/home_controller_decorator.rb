Spree::HomeController.class_eval do

  helper 'spree/products'
  respond_to :html

  def index
    if session[:vehicle] == nil
      session[:vehicle] = "car"
      @vehicle = "car"
    end
    @searcher = Spree::Config.searcher_class.new(params.merge(:in_offert => true))
    @products = @searcher.retrieve_products
    respond_with(@products)
  end

  def choose_vehicle
    @vehicle = params[:id]
    session[:vehicle] = @vehicle
    render :partial => "spree/shared/search_tires"
  end

  def calc_tires
    
  end

end
