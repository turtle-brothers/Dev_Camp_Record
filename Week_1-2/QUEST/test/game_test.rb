require 'minitest/autorun'
require_relative '../lib/game'
require_relative '../lib/card'
require_relative '../lib/player'
require_relative '../lib/dealer'


class GameTest < Minitest::Test

    def test_show_info
        ##show_info確認
        player = Player.new(Card.new(:speade, 'K'), Card.new(:speade, '3'))
        player.cards.each do |card|
            assert_equal "あなたの引いたカードはスペードのKです。", player.show_info
        end
    end
end
