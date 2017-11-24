# Class to handle HTTP JSON requests
class HotelDataService
  def fetch_cities
    auth = { username: 'booking_hackathon_uganda', password: 'UgandaH4ckerz' }
    # response = HTTParty.get('http://localhost/stem/cities.json',
    #                         :basic_auth => auth).body

    response = HTTParty.get('https://distribution-xml.booking.com/2.0/json/cities?countries=ug',
                            basic_auth: auth).body
    JSON.parse(response)
  end

  def create_cities
    data = fetch_cities
    data['result'].each do |city|
      City.create(
        name: city['name'],
        country_id: 1,
        city_id: city['city_id']
      )
    end
  end

  def fetch_hotels(city)
    # response = HTTParty.get('http://localhost/stem/cities.json').body

    auth = { username: 'booking_hackathon_uganda', password: 'UgandaH4ckerz' }
    url = "https://distribution-xml.booking.com/2.0/json/hotels?city_ids=#{city.city_id}&extras=hotel_info,hotel_photos"
    
    #logger.info("Query URL: #{url}")
    response = HTTParty.get(url,
                            basic_auth: auth).body
    JSON.parse(response)
  end

  def create_hotels(city)
    data = fetch_hotels(city)
    data['result'].each do |hotel|
      hotel_info = hotel['hotel_data']
      Hotel.create(
        name: hotel_info['name'],
        city_id: city.id,
        latitude:  hotel_info['location']['latitude'],
        longitude: hotel_info['location']['longitude'],
        intro_message: hotel_info['hotelier_welcome_message'],
        number_of_rooms: hotel_info['number_of_rooms'],
        creditcard_required: hotel_info['creditcard_required'],
        url_link: hotel_info['url'],
        image_url_300: hotel_info['hotel_photos'].first['url_max300'],
        image_url_original: hotel_info['hotel_photos'].first['url_original']
      )
    end
  end
end
