Spree::HomeController.class_eval do

  helper 'spree/products'
  respond_to :html

  def index
    session[:vehicle] = "car" if session[:vehicle] == nil
    @searcher = Spree::Config.searcher_class.new(params.merge(:in_offert => true))
    @products = @searcher.retrieve_products
    respond_with(@products)
  end

  def choose_vehicle

  end

end
