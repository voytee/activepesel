# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext'

module Activepesel
  class Pesel
    class << self
      delegate :generate_all, :generate_one, to: :'Activepesel::PeselGenerator'
    end

    DIGIT_WEIGHTS = [1, 3, 7, 9, 1, 3, 7, 9, 1, 3, 1].freeze

    attr_reader :number

    delegate :date_of_birth, :sex, to: :personal_data

    def initialize(number)
      @number = number
    end

    def valid?
      digits.size == 11 && (control_value % 10).zero?
    end

    def personal_data
      @personal_data ||= PersonalData.new(self) if @number
    end

    def digits
      @number.chars.select { |digit| digit.to_i.to_s == digit }.map(&:to_i)
    end

    private

    def control_value
      DIGIT_WEIGHTS.each_with_index.reduce(0) { |sum, (factor, idx)| sum + (factor * digits[idx]) }
    end
  end
end
