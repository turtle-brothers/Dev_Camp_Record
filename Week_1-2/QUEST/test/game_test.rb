require 'minitest/autorun'
require_relative '../lib/game'
require_relative '../lib/card'
require_relative '../lib/player'
require_relative '../lib/dealer'


class GameTest < Minitest::Test

    def setup
        card1 = Card.new(:speade, 'K')
        card2 = Card.new(:speade, '10')
        card3 = Card.new(:speade, '9')
        card4 = Card.new(:speade, 'A')
        game = Game.new
        @cards = Card.deck_generator
    end

    def test_game
        text << EOS
            ブラックジャックを開始します。
            あなたの引いたカードはスペードのKです。
            あなたの引いたカードはスペードの10です。
            ディーラーの引いたカードはスペードの9です。
            ディーラーの2枚目のカードは分かりません。
            あなたの現在の得点は15です。カードを引きますか？（y/n）
            n
            ディーラーの2枚目のカードはスペードのQです。
            ディーラーの得点は20です。
            ディーラーの勝ちです！
            ブラックジャックを終了します。
        EOS
        assert_equal text, game
    end
end
