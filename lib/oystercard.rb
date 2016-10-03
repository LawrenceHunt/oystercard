class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  STARTING_BALANCE = 0

  attr_reader :balance

  def initialize(balance = STARTING_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} reached, you posho!" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end
  def deduct(amount)
    @balance -= amount
  end

    def in_journey?
    @in_journey
    end

    def touch_in
      fail "Minimum balance of #{MINIMUM_BALANCE} not reached" if @balance < MINIMUM_BALANCE
      @in_journey = true
    end

    def touch_out
      @in_journey = false
    end

end
