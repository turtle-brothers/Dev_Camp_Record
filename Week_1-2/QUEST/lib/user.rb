class User

    def hit(card)
        cards << card
    end

    def bust
        total > 21
    end

    def total
        if cards.map(&:convert_number).include?([1, 11])
            ##1, 11 の両方のパターンをマッピング[*, 1]と[*, 11]し、それぞれ和を計算。21以下でフィルタして、最大値を取り出す。
            [cards.map(&:convert_number).flatten.reject{|e| e == 1}.sum, cards.map(&:convert_number).flatten.reject{|e| e == 11}.sum].select {|e| 21 >= e }.max
        else
            cards.map(&:convert_number).sum
        end
    end

end
