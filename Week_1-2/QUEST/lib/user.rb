class User

    #カード追加
    def hit(card)
        cards << card
    end

    #カード合計値が21以上
    def bust
        total > 21
    end

    #カード合計値を計算
    def total
        # print cards
        if cards.map(&:convert_number).include?([1, 11])
            ##1, 11 の両方のパターンをマッピング[*, 1]と[*, 11]し、それぞれ和を計算。21以下でフィルタして、最大値を取り出す。
            # [cards.map(&:convert_number).flatten.reject{|e| e == 1}.sum, cards.map(&:convert_number).flatten.reject{|e| e == 11}.sum].select {|e| 21 >= e }.max
            case_ace_sum = cards.map(&:convert_number).flatten.reject{|e| e == 1}.sum
            case_eleven_sum = cards.map(&:convert_number).flatten.reject{|e| e == 11}.sum
            (case_ace_sum < 22) && (case_eleven_sum < 22) ? [case_ace_sum, case_eleven_sum].max : [case_ace_sum, case_eleven_sum].min
        else
            cards.map(&:convert_number).sum
        end
    end

end
