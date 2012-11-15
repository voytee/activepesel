require 'test_helper'
class PeselValidatorTest < ActiveSupport::TestCase

  fixtures :users

  test "Record should be invalid" do
    assert_equal false, users('invalid').valid?
    assert_equal false, users('invalid_numbers').valid?
  end
  
  test "Record should have an error_message" do
    user = users('invalid')
    user.valid?
    assert_equal ["is invalid"], user.errors[:dads_pesel]
  end

  test "Record should be valid" do
    assert_equal true, users('18xx').valid?
    assert_equal true, users('19xx').valid?
    assert_equal true, users('20xx').valid?
    assert_equal true, users('21xx').valid?
    assert_equal true, users('22xx').valid?
  end

  test "Record with blank pesel should be valid" do
    assert_equal true, users('blank').valid?
  end

end
