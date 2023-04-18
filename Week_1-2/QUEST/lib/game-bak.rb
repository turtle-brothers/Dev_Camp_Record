
# ・ルール
# ・実行開始時、ディーラーとプレイヤー全員に２枚ずつカードが配られる
# ・自分のカードの合計値が21に近づくよう、カードを追加するか、追加しないかを決める
# ・カードの合計値が21を超えてしまった時点で、その場で負けが確定する
# ・プレイヤーはカードの合計値が21を超えない限り、好きなだけカードを追加できる
# ・ディーラーはカードの合計値が17を超えるまでカードを追加する


# ・カード
# ・2から9までは、書かれている数の通りの点数
# ・10,J,Q,Kは10点
# ・Aは1点あるいは11点として、手の点数が最大となる方で数える

require_relative '../lib/card'
require_relative '../lib/player'
require_relative '../lib/dealer'

class Game

    def start
        puts "ブラックジャックを開始します。"
        initialize_game
        show_info
        game_play
    end

    def initialize_game
        @cards = Card.deck_generator.shuffle
        # print @cards.slice!(0, 2)

        @player = Player.new(*@cards.slice!(0, 2))
        @dealer = Dealer.new(*@cards.slice!(0, 2))
        # print @player.send(:cards)
        # print @dealer.send(:cards)
    end

    def show_info
        @player.cards.each do |card|
            show_player_info(card.send(:suit), card.send(:number))
        end

        show_dealer_info(@dealer.cards[0].send(:suit), @dealer.cards[0].send(:number))
        puts "ディーラーの2枚目のカードは分かりません。"
    end

    def game_play
        until @player.stop
            player_hit_stand
        end
    end

    def player_hit_stand
        puts "あなたの現在の得点は#{@player.total}です。カードを引きますか？（y/n）"
        input = gets.chomp.downcase
        if input == 'y'
            card = @cards.slice!(0, 1)
            @player.hit(card)
            # show_player_info(@player.cards[-1].send(:suit), @player.cards[-1].send(:number))
        else
            @player.stand!
        end
    end








    def show_player_info(suit, number)
        player_card = Card.new(suit, number)
        puts "あなたの引いたカードは#{player_card.card_info}"
    end

    def show_dealer_info(suit, number)
        dealer_card = Card.new(suit, number)
        puts "ディーラーの引いたカードは#{dealer_card.card_info}"
    end

end

@game = Game.new
@game.start
