module Activepesel
  class PeselGenerator
    
    SEX_CODES = {
      1 => [1, 3, 5, 7, 9],
      2 => [0, 2, 4, 6, 8]
    }.freeze
    
    class << self
      
      def generate(*args)
        raise(::ArgumentError, "Bad argument! You can pass :all or :one") unless [:all, :one].include?(args[0])
        options = args.extract_options!
        raise(::ArgumentError, "Date of birth can only be from range: (1800-01-01..2299-12-31)") if !options[:date_of_birth].respond_to?(:to_date) || !(Date.new(1800,1,1)..Date.new(2299,12,31)).include?(options[:date_of_birth].to_date)
        raise(::ArgumentError, "Sex can only be set to 1 - males and 2 - females") if !options[:sex].respond_to?(:to_i) || ![1,2].include?(options[:sex].to_i)
        send(args.first, options)
      end
      
      private

      def one(options)
        incomplete_pesel = "#{date_of_birth_code(options[:date_of_birth])}#{varying_codes[rand(998)]}#{sex_codes(options[:sex])[rand(4)]}"
        Pesel.new("#{incomplete_pesel}#{control_digit(incomplete_pesel)}")
      end

      def all(options)
        [].tap do |pesels|
          varying_codes.each do |varying_code|
            sex_codes(options[:sex]).each do |sex_code|
              incomplete_pesel = "#{date_of_birth_code(options[:date_of_birth])}#{varying_code}#{sex_code}"
              pesels << Pesel.new("#{incomplete_pesel}#{control_digit(incomplete_pesel)}")
            end
          end
        end
      end

      def control_digit(incomplete_pesel)
        digits = incomplete_pesel.split("").map(&:to_i)
        (10 - Pesel::DIGIT_WEIGHTS[0..-2].each_with_index.inject(0){|sum, (factor, idx)| sum + factor * digits[idx]})%10
      end
      
      def sex_codes(sex)
        SEX_CODES[sex.to_i]
      end
      
      def varying_codes
        (0..999).to_a.map{|code| sprintf("%03d", code)}
      end
      
      def date_of_birth_code(date_of_birth)
        [year_code(date_of_birth.to_date.year), month_code(date_of_birth.to_date.year, date_of_birth.to_date.month), day_code(date_of_birth.to_date.day)].join
      end
      
      def century(year)
        year / 100
      end

      def year_code(year)
        sprintf("%02d", year - 100 * century(year))
      end

      def month_code(year, month)
        sprintf("%02d", month + PersonalData::DELTA[century(year)])
      end

      def day_code(day)
        sprintf("%02d", day)
      end

    end
  end
end
