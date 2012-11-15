module Activepesel
  class PersonalData
    
    DELTA = {
      18 => 80,
      19 =>  0,
      20 => 20,
      21 => 40,
      22 => 60
    }.freeze

    attr_reader :date_of_birth, 
                :sex

    def initialize(pesel)
      @date_of_birth, @sex = get_date_of_birth(pesel), get_sex(pesel)
    end

    private
    
    def get_century(pesel)
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
      pesel.number[0..1].to_i + 100 * get_century(pesel)
    end

    def month(pesel)
      pesel.number[2..3].to_i - DELTA[get_century(pesel)]
    end
    
    def day(pesel)
      pesel.number[4..5].to_i
    end

    def get_date_of_birth(pesel)
      if pesel.valid?
        begin
          Date.new(year(pesel), month(pesel), day(pesel)) 
        rescue ArgumentError
          return nil
        end
      end
    end
    
    # ISO/IEC 5218
    def get_sex(pesel)
      pesel.valid? ? (pesel.digits[9] % 2 == 0 ? 2 : 1) : 9
    end
    
  end
end
