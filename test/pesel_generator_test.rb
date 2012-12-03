require 'test_helper'

class PeselGeneratorTest < ActiveSupport::TestCase

  test "PeselGenerator.generate with wrong args should raise a ArgumentError" do
    assert_raise ArgumentError, "Bad argument! You can pass :all or :one" do
      Activepesel::PeselGenerator.generate :foo, :sex =>1, :date_of_birth => Date.new(1982,6,2)
    end
  end

  test "PeselGenerator.generate with wrong date should raise a ArgumentError" do
    assert_raise ArgumentError, "Date of birth can only be from range: (1800-01-01..2299-12-31)" do
      Activepesel::PeselGenerator.generate :foo, :sex =>333, :date_of_birth => Date.new(1982,6,2)
    end
  end

  test "PeselGenerator.generate with wrong sex should raise a ArgumentError" do
    assert_raise ArgumentError, "Sex can only be set to 1 - males and 2 - females" do
      Activepesel::PeselGenerator.generate :foo, :sex =>333, :date_of_birth => Date.new(1982,6,2)
    end
  end
  
  test "PeselGenerator should generate valid pesel for 18XX's" do
    assert_equal true, Activepesel::PeselGenerator.generate(:one, :sex =>1, :date_of_birth => Date.new(1807,2,15)).valid?
  end

  test "PeselGenerator should generate valid pesel for 19XX's" do
    assert_equal true, Activepesel::PeselGenerator.generate(:one, :sex =>1, :date_of_birth => Date.new(1907,2,15)).valid?
  end

  test "PeselGenerator should generate valid pesel for 20XX's" do
    assert_equal true, Activepesel::PeselGenerator.generate(:one, :sex =>1, :date_of_birth => Date.new(2007,2,15)).valid?
  end

  test "PeselGenerator should generate valid pesel for 21XX's" do
    assert_equal true, Activepesel::PeselGenerator.generate(:one, :sex =>1, :date_of_birth => Date.new(2107,2,15)).valid?
  end

  test "PeselGenerator should generate valid pesel for 22XX's" do
    assert_equal true, Activepesel::PeselGenerator.generate(:one, :sex =>1, :date_of_birth => Date.new(2207,2,15)).valid?
  end
  


  
end
