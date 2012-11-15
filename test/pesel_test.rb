require 'test_helper'

class PeselTest < ActiveSupport::TestCase

  test "valid? should return false for invalid pesel" do
    assert_equal false, Activepesel::Pesel.new("12345678901").valid?
  end

  test "valid? should return true for valid pesel" do
    assert_equal true, Activepesel::Pesel.new("82060202039").valid?
  end

  test "valid? should return false for a tricky one" do
    assert_equal false, Activepesel::Pesel.new("82c60202039").valid?
  end

  test "Personal data should give 1982.06.02 as date of birth and 1 as sex (male)" do
    assert_equal Date.new(1982,6,2), Activepesel::Pesel.new("82060202039").get_personal_data.date_of_birth
    assert_equal 1, Activepesel::Pesel.new("82060202039").get_personal_data.sex
  end

  test "Personal data should give NIL as date of birth and 9 (ISO/IEC 5218) as sex (unknown) for a invalid pesel" do
    assert_equal nil, Activepesel::Pesel.new("123123").get_personal_data.date_of_birth
    assert_equal 9, Activepesel::Pesel.new("123123").get_personal_data.sex
  end

  
end
