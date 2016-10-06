class Journey

  MINIMUM_FARE = 1

attr_reader :entry_station, :exit_station

  def initialize(entry_station)
    @in_journey =  true
    @entry_station = entry_station
    @dont_stop_believing = true
  end

  def in_journey?
    @in_journey
  end

  def finish_journey(exit_station)
    @exit_station = exit_station
    @in_journey = false
  end

  def calculate_fare
    MINIMUM_FARE
  end

  def stations
    {entry_station: entry_station, exit_station: exit_station}
  end

end
