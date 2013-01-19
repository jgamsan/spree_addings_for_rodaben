Spree::Image.class_eval do
  Spree::Image.attachment_definitions[:attachment][:styles].merge!(
      :ceelabel => {:format => :jpg, :processors => [:greenlabel]},
      :offertmark => {:format => :jpg,, :processors => [:offertmark]},
      :newmark => {:format => :jpg,, :processors => [:newmark]}
  )
end