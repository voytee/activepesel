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
    assert_equal Date.new(1982,6,2), Activepesel::Pesel.new("82060202039").personal_data.date_of_birth
    assert_equal 1, Activepesel::Pesel.new("82060202039").personal_data.sex
    assert_equal 2, Activepesel::Pesel.new("84051902641").personal_data.sex
  end
  
  test "Delegation of personal_data attributes" do
    assert_equal Date.new(1982,6,2), Activepesel::Pesel.new("82060202039").date_of_birth
    assert_equal 1, Activepesel::Pesel.new("82060202039").sex
  end

  test "Personal data should give NIL as date of birth and 9 (ISO/IEC 5218) as sex (unknown) for a invalid pesel" do
    assert_equal nil, Activepesel::Pesel.new("123123").personal_data.date_of_birth
    assert_equal 9, Activepesel::Pesel.new("123123").personal_data.sex
  end

  test "Pesel.generate :all should return 5000 valid male pesel numbers" do
    pesels = Activepesel::Pesel.generate(:all, :sex => 1, :date_of_birth => Date.new(1982,6,2))
    assert_equal 5000, pesels.size
    assert_equal true, !pesels.map(&:valid?).include?(false)
    assert_equal nil,  pesels.map(&:sex).detect{|t| t!=1} 
    assert_equal nil,  pesels.map(&:date_of_birth).detect{|t| t!=Date.new(1982,6,2)}
  end

  test "Pesel.generate :all should return 5000 valid female pesel numbers" do
    pesels = Activepesel::Pesel.generate(:all, :sex => 2, :date_of_birth => Date.new(1982,6,2))
    assert_equal 5000, pesels.size
    assert_equal true, !pesels.map(&:valid?).include?(false) 
    assert_equal nil,  pesels.map(&:sex).detect{|t| t!=2}
    assert_equal nil,  pesels.map(&:date_of_birth).detect{|t| t!=Date.new(1982,6,2)}
  end

  test "Pesel.generate :one should return one male randomly picked from the pesel pool pesel number" do
    pesel = Activepesel::Pesel.generate(:one, :sex => 1, :date_of_birth => Date.new(1982,6,2))
    assert_equal true, pesel.valid?
    assert_equal 1, pesel.sex
    assert_equal Date.new(1982,6,2), pesel.date_of_birth
  end

  test "Pesel.generate :one should return one female randomly picked from the pesel pool pesel number" do
    pesel = Activepesel::Pesel.generate(:one, :sex => 2, :date_of_birth => Date.new(1982,6,2))
    assert_equal true, pesel.valid?
    assert_equal 2, pesel.sex
    assert_equal Date.new(1982,6,2), pesel.date_of_birth
  end



  
end
