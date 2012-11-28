Spree::HomeController.class_eval do
  helper 'spree/products'
  respond_to :html

  def index
    @searcher = Spree::Config.searcher_class.new(params.merge(:in_offert => true, :per_page => 3))
    @searcher.current_user = try_spree_current_user
    @products = @searcher.retrieve_products
    respond_with(@products)
  end

end
