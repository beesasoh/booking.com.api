# City base class
class City < ApplicationRecord
  has_many :hotels

  def find_hotels
    return hotels if hotels.count > 0

    logger.info('Querying for hotels')
    HotelDataService.new.create_hotels(self)
    reload.hotels
  end
end
