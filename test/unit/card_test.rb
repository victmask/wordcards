require 'test_helper'

class CardTest < ActiveSupport::TestCase
  def setup
    mocha_teardown
  end

  def teardown
    mocha_teardown
  end

  test "should not save card without word" do
    card = Card.new
    assert !card.save, "Saved card without word"
  end

  test "should have uuid generated" do
    expected_uuid = '1234567890'
    SecureRandom.expects(:uuid).returns(expected_uuid)

    card = Card.create(word: 'cardTest1')

    assert_equal expected_uuid, card.uuid
  end

  test "should have default image" do
    card = Card.create(word: 'card1')
    assert_equal Card::DEFAULT_IMAGE, card.image_src
  end

  # test "the truth" do
  #   assert true
  # end
end
