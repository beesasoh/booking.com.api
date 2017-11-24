# Hotel controller
class HotelsController < ApplicationController
  def index
    @hotels = Hotel.all.order('created_at desc')
  end

  def search
    @key = params[:key]
    city = City.find_by('name LIKE ?', "%#{@key}%")

    @hotels = if city.nil?
                []
              else
                city.find_hotels
              end
  end

  def show; end
end
