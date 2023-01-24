# frozen_string_literal: true

module Activepesel
  class PersonalData
    DELTA = {
      18 => 80,
      19 => 0,
      20 => 20,
      21 => 40,
      22 => 60,
    }.freeze

    attr_reader :date_of_birth,
                :sex

    def initialize(pesel)
      @date_of_birth = get_date_of_birth(pesel)
      @sex = get_sex(pesel)
    end

    private

    def get_century(pesel) # rubocop:disable Metrics/MethodLength
      case pesel.number[2..3].to_i
      when (81..92)
        18
      when (1..12)
        19
      when (21..32)
        20
      when (41..52)
        21
      when (61..72)
        22
      end
    end

    def year(pesel)
      pesel.number[0..1].to_i + (100 * get_century(pesel))
    end

    def month(pesel)
      pesel.number[2..3].to_i - DELTA[get_century(pesel)]
    end

    def day(pesel)
      pesel.number[4..5].to_i
    end

    def get_date_of_birth(pesel)
      return unless pesel.valid?

      begin
        Date.new(year(pesel), month(pesel), day(pesel))
      rescue ArgumentError
        nil
      end
    end

    # ISO/IEC 5218
    def get_sex(pesel)
      if pesel.valid?
        pesel.digits[9].even? ? 2 : 1
      else
        9
      end
    end
  end
end
