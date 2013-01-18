Spree::Image.class_eval do
  Spree::Image.attachment_definitions[:attachment][:styles].merge!(
      :ceelabel => {:format => :jpg, :processors => [:greenlabel]},
      :offertmark => {:processors => [:thumbnail, :offertmark],
                     :styles => {
                        :mini => {
                          :geometry => '48x48>',
                          :offertmark_position => "SouthWest",
                          :format => :png
                        },
                        :small => {
                          :geometry => '100x100>',
                          :offertmark_position => "SouthWest",
                          :format => :png
                        },
                        :product => {
                          :geometry => '240x240>',
                          :offertmark_position => "SouthWest",
                          :format => :png
                        },
                        :large => {
                          :geometry => '600x600>',
                          :offertmark_position => "SouthWest",
                          :format => :png
                        },
                      },
                     :default_style => :product,
                     :url => "/spree/products/:id/:style/:basename.:extension",
                     :path => ":rails_root/public/spree/products/:id/:style/:basename.:extension"
      }
  )
end