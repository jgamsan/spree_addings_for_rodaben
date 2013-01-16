Spree::Image.class_eval do
  Image.attachment_definitions[:attachment][:styles].merge!(
      :ceelabel => {:format => :png, :processor => :greenlabel}
)
end