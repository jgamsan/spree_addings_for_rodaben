module Spree
  class CalcTiresController < BaseController
    def calc_equivalents

      respond_to do |format|
        format.js
      end
    end
  end
end
