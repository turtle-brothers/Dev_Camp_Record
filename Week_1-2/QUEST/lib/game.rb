require_relative '../lib/card'
require_relative '../lib/player'
require_relative '../lib/dealer'

class Game

    def initialize
        @cards = Card.deck_generator.shuffle
        @player = Player.new(Card.new(@cards.shift.send(:suit), @cards.shift.send(:number)), Card.new(@cards.shift.send(:suit), @cards.shift.send(:number)))
        @dealer = Dealer.new(Card.new(@cards.shift.send(:suit), @cards.shift.send(:number)), Card.new(@cards.shift.send(:suit), @cards.shift.send(:number)))
    end

    def start
        puts "ブラックジャックを開始します。"
        initialize
        show_info
        game_play
        puts "ブラックジャックを終了します。"
    end

    #カード情報の開示
    def show_info
        @player.cards.each do |card|
            show_player_info(card)
        end

        show_dealer_info(@dealer.cards[0])
        puts "ディーラーの2枚目のカードは分かりません。"
    end

    #ゲームの処理
    def game_play
        until @player.finished
            player_hit_stand
        end

        if @player.bust
            puts "#{@player.total}点でバーストしました。"
        end

        if @player.twenty_one
            show_player_total_info
        end

        puts "ディーラーの2枚目のカードは#{@dealer.cards[1].card_info}"

        until @dealer.finished
            dealer_hit
        end

        show_dealer_total_info

        if @dealer.bust
            puts "#{@dealer.total}点でバーストしました。"
        end

        bust_judge_result

    end

    #プレイヤーのカード追加を判定
    def player_hit_stand
        puts "あなたの現在の得点は#{@player.total}です。カードを引きますか？（y/n）"
        input = gets.chomp.downcase
        if input == 'y'
            card = Card.new(@cards.shift.send(:suit), @cards.shift.send(:number))
            @player.hit(card)
            show_player_info(card)
        else
            @player.stand!
        end
    end

    #ディーラーのカード追加を判定
    def dealer_hit
        puts "ディーラーの現在の得点は#{@dealer.total}です。"
        card = Card.new(@cards.shift.send(:suit), @cards.shift.send(:number))
        @dealer.hit(card)
        show_dealer_info(card)
    end

    #プレイヤーのカード情報を表示
    def show_player_info(card)
        puts "あなたの引いたカードは#{card.card_info}"
    end

    #ディーラーのカード情報を表示
    def show_dealer_info(card)
        puts "ディーラーの引いたカードは#{card.card_info}"
    end

    #プレイヤーのカード合計値を表示
    def show_player_total_info
        puts "あなたの得点は#{@player.total}です。"
    end

    #ディーラーのカード合計値を表示
    def show_dealer_total_info
        puts "ディーラーの得点は#{@dealer.total}です。"
    end

    #勝敗の判定
    def bust_judge_result
        if (@player.total > 21) && (@dealer.total > 21)
            puts "ディーラーの勝ちです！"
        elsif @player.total > 21
            puts "ディーラーの勝ちです！"
        elsif @dealer.total > 21
            puts "あなたの勝ちです！"
        else
            case @player.total <=> @dealer.total
            when 1 then puts "あなたの勝ちです！"
            when -1 then puts "ディーラーの勝ちです！"
            else puts "ディーラーの勝ちです！"
            end
        end
    end
end

@game = Game.new
@game.start
