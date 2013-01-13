Spree::Image.class_eval do
  Image.attachment_definitions[:attachment][:styles].merge!(
      :eco => '200x200>',
      :offert => '284x284>'
)

end