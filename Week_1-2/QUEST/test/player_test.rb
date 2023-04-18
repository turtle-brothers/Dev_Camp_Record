require 'minitest/autorun'
require_relative '../lib/card'
require_relative '../lib/user'
require_relative '../lib/player'

class PlayerTest < Minitest::Test

    def test_total_hit
        ##total確認
        player = Player.new(Card.new(:speade, 'K'), Card.new(:speade, '3'))
        assert_equal 13, player.total

        ##hit確認
        player.hit(Card.new(:speade, '4'))
        assert_equal 17, player.total
    end

    def test_stop_twenty_one_20
        ##total, stop確認_20
        player = Player.new(Card.new(:speade, 'Q'), Card.new(:speade, 'K'))
        assert_equal 20, player.total
        assert_equal false, player.stop

        ##twenty_one確認_20
        assert_equal false, player.twenty_one
    end

    def test_stop_twenty_one_21
        ##total, stop確認_21
        player = Player.new(Card.new(:speade, 'Q'), Card.new(:speade, 'K'))
        player.hit(Card.new(:speade, 'A'))
        assert_equal 21, player.total
        assert_equal true, player.stop

        ##twenty_one確認_21
        assert_equal true, player.twenty_one
    end

    def test_stop_twenty_one_22
        ##total, stop確認_22
        player = Player.new(Card.new(:speade, 'Q'), Card.new(:speade, 'K'))
        player.hit(Card.new(:speade, '2'))
        assert_equal 22, player.total
        assert_equal true, player.stop

        ##twenty_one確認_22
        assert_equal false, player.twenty_one
    end

    def test_bust
        ##bust確認_21
        player = Player.new(Card.new(:speade, 'K'), Card.new(:speade, '10'))
        player.hit(Card.new(:speade, 'A'))
        assert_equal 21, player.total
        assert_equal false, player.bust

        ##bust確認_22
        player = Player.new(Card.new(:speade, 'K'), Card.new(:speade, '10'))
        player.hit(Card.new(:speade, '2'))
        assert_equal 22, player.total
        assert_equal true, player.bust
    end

    def test_stand_stop
        ##stand, stop確認@false
        player = Player.new(Card.new(:speade, 'K'), Card.new(:speade, '10'))
        assert_equal false, player.stand
        assert_equal false, player.stop

        ##stand, stop確認@true
        player.stand!
        assert_equal true, player.stand
        assert_equal true, player.stop
    end

    def test_total_hit
        ##total確認
        player = Player.new(Card.new(:speade, 'A'), Card.new(:speade, '3'))
        assert_equal 14, player.total
    end
end
