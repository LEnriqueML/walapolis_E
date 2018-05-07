class ApplicationController < ActionController::Base
	def set_greeting
    current_hour = Time.zone.now.hour
    #Entre las 5:00 AM a las 11:59 AM => "BUENOS DÍAS"
    if current_hour >= 5 && current_hour < 12
      @saludo = "Buenos días"
    #Entre las 12:00 PM a las 8:00 PM => "BUENAS TARDES"
    elsif current_hour >= 12 && current_hour < 20
      @saludo = "Buenas tardes"
    #Entre las 7:31 PM a las 4:59 PM => "BUENAS NOCHES"
    else
      @saludo = "Buenas noches"
        
    end
  end
end
