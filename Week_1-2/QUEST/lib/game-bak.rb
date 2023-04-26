require_relative '../lib/card'
require_relative '../lib/player'
require_relative '../lib/dealer'

class Game

    def start
        puts "ブラックジャックを開始します。"
        initialize_game
        show_info
        game_play
        puts "ブラックジャックを終了します。"
    end

    def initialize_game
        @cards = Card.deck_generator.shuffle
        # player_shuffle_card = @cards.slice!(0, 2)
        # print player_shuffle_card
        @player = Player.new(Card.new(@cards.shift.send(:suit), @cards.shift.send(:number)), Card.new(@cards.shift.send(:suit), @cards.shift.send(:number)))
        @dealer = Dealer.new(Card.new(@cards.shift.send(:suit), @cards.shift.send(:number)), Card.new(@cards.shift.send(:suit), @cards.shift.send(:number)))
        # @dealer = Dealer.new(Card.new(@cards.slice!(0, 2)))
        # print @player.cards
        # print @dealer
    end

    def show_info
        @player.cards.each do |card|
            # print card.send(:suit)
            show_player_info(card)
        end

        show_dealer_info(@dealer.cards[0])
        puts "ディーラーの2枚目のカードは分かりません。"
    end

    def game_play
        until @player.stop
            player_hit_stand
        end

        if @player.bust
            puts "#{@player.total}点でバーストしました。"
        end

        if @player.twenty_one
            show_player_total_info
        end

        puts "ディーラーの2枚目のカードは#{@dealer.cards[1].card_info}"

        until @dealer.stop
            dealer_hit
        end

        show_dealer_total_info

        if @dealer.bust
            puts "#{@dealer.total}点でバーストしました。"
        end

        bust_judge_result

        # if @player.total > @dealer.total
        #     puts "あなたの勝ちです！"
        # elsif  @player.total > @dealer.total
        #     puts "ディーラーの勝ちです！"
        # else puts "ディーラーの勝ちです！"
        # end

    end

    def player_hit_stand
        puts "あなたの現在の得点は#{@player.total}です。カードを引きますか？（y/n）"
        input = gets.chomp.downcase
        if input == 'y'
            card = Card.new(@cards.shift.send(:suit), @cards.shift.send(:number))
            # card = @cards.slice!(0, 1)
            @player.hit(card)
            # print card
            show_player_info(card)
        else
            @player.stand!
        end
    end

    def dealer_hit
        puts "ディーラーの現在の得点は#{@dealer.total}です。"
        card = Card.new(@cards.shift.send(:suit), @cards.shift.send(:number))
        @dealer.hit(card)
        show_dealer_info(card)
    end


    def show_player_info(card)
        # player_card = Card.new(suit, number)
        puts "あなたの引いたカードは#{card.card_info}"
    end

    def show_dealer_info(card)
        # dealer_card = Card.new(suit, number)
        puts "ディーラーの引いたカードは#{card.card_info}"
    end

    def show_player_total_info
        # player_card = Card.new(suit, number)
        puts "あなたの得点は#{@player.total}です。"
    end

    def show_dealer_total_info
        # player_card = Card.new(suit, number)
        puts "ディーラーの得点は#{@dealer.total}です。"
    end

    def bust_judge_result
        if (@player.total > 21) && (@player.total > 21)
            puts "ディーラーの勝ちです！"
        elsif @player.total > 21
            puts "ディーラーの勝ちです！"
        elsif @dealer.total > 21
            puts "あなたの勝ちです！"
        else
            judge_result
        end
    end

    def judge_result
        case @player.total <=> @dealer.total
        when 1 then puts "あなたの勝ちです！"
        when -1 then puts "ディーラーの勝ちです！"
        else puts "ディーラーの勝ちです！"
        end
    end

end

@game = Game.new
@game.start
