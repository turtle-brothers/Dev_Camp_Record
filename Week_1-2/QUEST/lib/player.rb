require_relative '../lib/User'

class Player < User
    attr_reader :cards

    def initialize(first_card, second_card)
        @cards = [first_card, second_card]
        @stand = false
    end

    def stop
        total >= 21 || stand
    end

    def stand
        @stand
    end

    def stand!
        @stand = true
    end

    def twenty_one
        total == 21
    end
end
