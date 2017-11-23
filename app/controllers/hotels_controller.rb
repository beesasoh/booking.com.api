# Hotel controller
class HotelsController < ApplicationController
  def index
    @hotels = Hotel.all.order('created_at desc')
  end

  def search; end

  def show; end
end
