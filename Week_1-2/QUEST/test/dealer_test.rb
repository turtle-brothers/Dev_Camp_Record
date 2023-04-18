require 'minitest/autorun'
require_relative '../lib/card'
require_relative '../lib/user'
require_relative '../lib/dealer'

class DealerTest < Minitest::Test

    def test_total_hit
        ##total確認
        dealer = Dealer.new(Card.new(:speade, 'K'), Card.new(:speade, '3'))
        assert_equal 13, dealer.total

        ##hit確認
        dealer.hit(Card.new(:speade, '4'))
        assert_equal 17, dealer.total
    end

    def test_stop
        ##stop確認_16
        dealer = Dealer.new(Card.new(:speade, 'K'), Card.new(:speade, '6'))
        assert_equal false, dealer.stop

        ##stop確認_17
        dealer = Dealer.new(Card.new(:speade, 'K'), Card.new(:speade, '7'))
        assert_equal true, dealer.stop

    end

    def test_bust
        ##bust確認_21
        dealer = Dealer.new(Card.new(:speade, 'K'), Card.new(:speade, '10'))
        dealer.hit(Card.new(:speade, 'A'))
        assert_equal false, dealer.bust

        ##bust確認_22
        dealer = Dealer.new(Card.new(:speade, 'K'), Card.new(:speade, '10'))
        dealer.hit(Card.new(:speade, '2'))
        assert_equal true, dealer.bust
    end

end
