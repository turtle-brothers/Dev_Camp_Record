
class Card

    attr_reader :suit, :number

    SUITS = %i(spade heart diamond club)
    # SUITS = %i('スペード' 'ハート' 'ダイヤ' 'クラブ')
    NUMBERS = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']

    def initialize(suit, number)
        @suit = suit
        @number = number
    end

    def self.deck_generator
        SUITS.product(NUMBERS).map { |suit, num| self.new(suit, num) }
        # deck = []
        # SUITS.product(NUMBERS) { |suit| deck << suit }
        # print deck
    end

    def convert_number
        case number
        when 'J', 'Q', 'K'
            10
        when 'A'
            # 1
            [1, 11]
        else
            number.to_i
        end

    end

    def convert_text
        case suit
        when :spade then 'スペード'
        when :heart then 'ハート'
        when :diamond then 'ダイヤ'
        when :club then 'クラブ'
        end
    end

    def card_info
        "#{convert_text}の#{number}です。"
    end

end
