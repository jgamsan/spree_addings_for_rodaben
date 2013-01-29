Spree::Image.class_eval do
  Spree::Image.attachment_definitions[:attachment][:styles].merge!(
      :ceelabel => {:format => :png, :processors => [:greenlabel]},
      :offertmark => {:format => :png, :processors => [:offertmark]},
      :newmark => {:format => :png, :processors => [:newmark]}
  )

  after_save :check_cee_label, :on => :create

  def check_cee_label
    variante = Spree::Variant.find(self.viewable_id)
    if variante.images.count == 1
      update_cee_label_imagen
    end
  end
end