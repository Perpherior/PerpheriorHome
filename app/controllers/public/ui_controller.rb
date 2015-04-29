module Public
  class UiController < ActionController::Base
    layout "public"
    respond_to :html

    def index; end
  end
end