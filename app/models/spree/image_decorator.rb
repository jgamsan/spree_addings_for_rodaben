Spree::Image.class_eval do
  Spree::Image.attachment_definitions[:attachment][:styles].merge!(
      :ceelabel => {:format => :png, :processors => [:greenlabel]},
      :offertmark => {:format => :png, :processors => [:offertmark]},
      :newmark => {:format => :png, :processors => [:newmark]}
  )
end