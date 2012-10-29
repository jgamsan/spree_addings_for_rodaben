module Spree
  class CalcTiresController < BaseController
    def calc_equivalents
      @equivalents = 25
      respond_to do |format|
        format.html
        format.js
      end
    end
  end
end
