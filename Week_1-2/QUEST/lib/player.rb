require_relative '../lib/User'

class Player < User
    attr_reader :cards

    def initialize(first_card, second_card)
        @cards = [first_card, second_card]
        @stand = false
    end

    #カード合計値が21以上、または、スタンドを宣言
    def finished
        total >= 21 || stand
    end

    #スタンドを確認
    def stand
        @stand
    end

    #スタンドを宣言
    def stand!
        @stand = true
    end

    #カード合計値が21
    def twenty_one
        total == 21
    end
end
