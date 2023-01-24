# frozen_string_literal: true

module Activepesel
  class PeselGenerator
    DATE_RANGE = (Date.new(1800, 1, 1)..Date.new(2299, 12, 31)).freeze
    SEX_CODES = {
      1 => [1, 3, 5, 7, 9],
      2 => [0, 2, 4, 6, 8],
    }.freeze

    class << self
      def generate_one(date_of_birth:, sex:)
        validate_params(date_of_birth, sex)
        one(date_of_birth, sex)
      end

      def generate_all(date_of_birth:, sex:)
        validate_params(date_of_birth, sex)
        all(date_of_birth, sex)
      end

      private

      def validate_params(date_of_birth, sex)
        if !date_of_birth.respond_to?(:to_date) || !DATE_RANGE.cover?(date_of_birth.to_date)
          raise(::ArgumentError, 'Date of birth can only be from range: (1800-01-01..2299-12-31)')
        end

        return unless !sex.respond_to?(:to_i) || ![1, 2].include?(sex.to_i)

        raise(::ArgumentError, 'Sex can only be set to 1 - males and 2 - females')
      end

      def one(date_of_birth, sex)
        incomplete_pesel = "#{date_of_birth_code(date_of_birth)}#{varying_codes[rand(998)]}#{sex_codes(sex)[rand(4)]}"
        Pesel.new("#{incomplete_pesel}#{control_digit(incomplete_pesel)}")
      end

      def all(date_of_birth, sex)
        [].tap do |pesels|
          varying_codes.each do |varying_code|
            sex_codes(sex).each do |sex_code|
              incomplete_pesel = "#{date_of_birth_code(date_of_birth)}#{varying_code}#{sex_code}"
              pesels << Pesel.new("#{incomplete_pesel}#{control_digit(incomplete_pesel)}")
            end
          end
        end
      end

      def control_digit(incomplete_pesel)
        digits = incomplete_pesel.chars.map(&:to_i)

        (10 - Pesel::DIGIT_WEIGHTS[0..-2].each_with_index.reduce(0) do |sum, (factor, idx)|
          sum + (factor * digits[idx])
        end) % 10
      end

      def sex_codes(sex)
        SEX_CODES[sex.to_i]
      end

      def varying_codes
        (0..999).to_a.map { |code| format('%03d', code) }
      end

      def date_of_birth_code(date_of_birth)
        [
          year_code(date_of_birth.to_date.year),
          month_code(date_of_birth.to_date.year, date_of_birth.to_date.month),
          day_code(date_of_birth.to_date.day),
        ].join
      end

      def century(year)
        year / 100
      end

      def year_code(year)
        format('%02d', year - (100 * century(year)))
      end

      def month_code(year, month)
        format('%02d', month + PersonalData::DELTA[century(year)])
      end

      def day_code(day)
        format('%02d', day)
      end
    end
  end
end
