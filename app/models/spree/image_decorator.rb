Spree::Image.class_eval do
  Spree::Image.attachment_definitions[:attachment][:styles].merge!(
      :ceelabel => {:format => :png, :processors => [:greenlabel]}
)
end