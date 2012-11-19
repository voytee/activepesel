require 'test_helper'

class PeselAttrTest < ActiveSupport::TestCase
  
  fixtures :users

  test "User object should respond to pesel_personal_data and return a PersonalData object" do
    assert_kind_of Activepesel::PersonalData,  users(:valid).mums_pesel_personal_data
  end

  test "Invalid pesel should get nil date_of_birth and sex=9 (ISO/IEC 5218)" do
    assert_equal nil, users("invalid").dads_pesel_personal_data.date_of_birth
    assert_equal nil, users("invalid").mums_pesel_personal_data.date_of_birth
    assert_equal 9, users("invalid").dads_pesel_personal_data.sex
    assert_equal 9, users("invalid").mums_pesel_personal_data.sex
    assert_equal nil, users("invalid_numbers").dads_pesel_personal_data.date_of_birth
    assert_equal nil, users("invalid_numbers").mums_pesel_personal_data.date_of_birth
    assert_equal 9, users("invalid_numbers").dads_pesel_personal_data.sex
    assert_equal 9, users("invalid_numbers").mums_pesel_personal_data.sex
  end

  test "Should get proper personal data for 18XX" do
    assert_equal Date.new(1801, 5, 20), users("18xx").dads_pesel_personal_data.date_of_birth
    assert_equal 1, users("18xx").dads_pesel_personal_data.sex 
    assert_equal Date.new(1801, 5, 20), users("18xx").mums_pesel_personal_data.date_of_birth
    assert_equal 2, users("18xx").mums_pesel_personal_data.sex 
  end

  test "Should get proper personal data for 19XX" do
    assert_equal Date.new(1982, 6, 2), users("19xx").dads_pesel_personal_data.date_of_birth
    assert_equal 1, users("19xx").dads_pesel_personal_data.sex 
    assert_equal Date.new(1984, 5, 19), users("19xx").mums_pesel_personal_data.date_of_birth
    assert_equal 2, users("19xx").mums_pesel_personal_data.sex 
  end

  test "Should get proper personal data for 20XX" do
    assert_equal Date.new(2010, 4, 4), users("20xx").dads_pesel_personal_data.date_of_birth
    assert_equal 1, users("20xx").dads_pesel_personal_data.sex 
    assert_equal Date.new(2010, 4, 4), users("20xx").mums_pesel_personal_data.date_of_birth
    assert_equal 2, users("20xx").mums_pesel_personal_data.sex 
  end

  test "Should get proper personal data for 21XX" do
    assert_equal Date.new(2134, 3, 30), users("21xx").dads_pesel_personal_data.date_of_birth
    assert_equal 1, users("21xx").dads_pesel_personal_data.sex 
    assert_equal Date.new(2134, 3, 30), users("21xx").mums_pesel_personal_data.date_of_birth
    assert_equal 2, users("21xx").mums_pesel_personal_data.sex 
  end
  
  test "Should get proper personal data for 22XX" do
    assert_equal Date.new(2222, 8, 21), users("22xx").dads_pesel_personal_data.date_of_birth
    assert_equal 1, users("22xx").dads_pesel_personal_data.sex 
    assert_equal Date.new(2222, 8, 21), users("22xx").mums_pesel_personal_data.date_of_birth
    assert_equal 2, users("22xx").mums_pesel_personal_data.sex 
  end

  test "Personal data should be nil for nil Pesel attributes" do
    user = User.create(:mums_pesel => nil)
    assert_equal nil, user.mums_pesel_personal_data
  end

end
