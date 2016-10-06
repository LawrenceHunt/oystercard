require_relative 'station'
require_relative 'journey'


class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  PENALTY_FARE = 6

attr_reader :balance, :list_of_journeys, :current_journey
  def initialize
    @balance = 0
    @list_of_journeys = []
  end

  def top_up(amount)
    if amount + balance > MAXIMUM_BALANCE
      fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded"
      @balance = MAXIMUM_BALANCE
    else @balance += amount
    end
  end

  def touch_in(station)
    fail 'Insufficient funds for jouney' if @balance < MINIMUM_BALANCE
    fine(nil) if touch_in_twice
    start_journey(station)
  end

  def touch_out(station)
    if touch_out_twice
      fine(station)
    else
      deduct(current_journey.calculate_fare)
      end_journey(station)
    end
  end

private

  def deduct(amount)
    @balance -= amount
  end

  def start_journey(station)
    @current_journey = Journey.new(station)
  end

  def end_journey(station)
    @current_journey.finish_journey(station)
    @list_of_journeys << @current_journey.stations
    @current_journey = nil
  end

  def fine(station)
      @balance -= PENALTY_FARE
    if touch_in_twice
      @list_of_journeys << {name: station, exit_station: "Unknown"}
      fail "Double touch-out! £#{PENALTY_FARE} for you!"
    elsif touch_out_twice
      @list_of_journeys << {name: "Unknown", exit_station: station}
      fail "Double touch-in! £#{PENALTY_FARE} for you!"
    end
  end

  def touch_out_twice
    !@current_journey
  end

  def touch_in_twice
    !!@current_journey
  end


end
