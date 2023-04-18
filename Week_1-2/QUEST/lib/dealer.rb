require_relative '../lib/User'

class Dealer < User
    attr_reader :cards

    def initialize(first_card, second_card)
        @cards = [first_card, second_card]
    end

    def stop
        total >= 17
    end

end
