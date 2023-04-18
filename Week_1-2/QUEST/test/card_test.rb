require 'minitest/autorun'
require_relative '../lib/card'

class CardTest < Minitest::Test

    def test_deck_generator
        ##全枚数確認
        cards = Card.deck_generator
        assert_equal 13 * 4, cards.count

        ##絵柄確認
        cards_suit = cards.group_by{ |s| s.suit }
        assert_equal [:spade, :heart, :diamond, :club], cards_suit.keys

        ##枚数確認
        cards_suit.values.each do |cards|
            assert_equal cards.map{ |n| n.number }, ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
        end
    end


    def test_convert_number
        card = Card.new(:spade, 'A')
        assert_equal 1, card.convert_number

        card = Card.new(:spade, '2')
        assert_equal 2, card.convert_number

        card = Card.new(:spade, '3')
        assert_equal 3, card.convert_number

        card = Card.new(:spade, '4')
        assert_equal 4, card.convert_number

        card = Card.new(:spade, '5')
        assert_equal 5, card.convert_number

        card = Card.new(:spade, '6')
        assert_equal 6, card.convert_number

        card = Card.new(:spade, '7')
        assert_equal 7, card.convert_number

        card = Card.new(:spade, '8')
        assert_equal 8, card.convert_number

        card = Card.new(:spade, '9')
        assert_equal 9, card.convert_number

        card = Card.new(:spade, '10')
        assert_equal 10, card.convert_number

        card = Card.new(:spade, 'J')
        assert_equal 10, card.convert_number

        card = Card.new(:spade, 'Q')
        assert_equal 10, card.convert_number

        card = Card.new(:spade, 'K')
        assert_equal 10, card.convert_number
    end

    def test_concert_text
        card = Card.new(:spade, 'K')
        assert_equal 'スペードのKです。', card.card_info

        card = Card.new(:heart, '8')
        assert_equal 'ハートの8です。', card.card_info

        card = Card.new(:diamond, 'A')
        assert_equal 'ダイヤのAです。', card.card_info

        card = Card.new(:club, '3')
        assert_equal 'クラブの3です。', card.card_info
    end

end
