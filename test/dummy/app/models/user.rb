class User < ActiveRecord::Base
  
  attr_accessible :dads_pesel, :mums_pesel
  pesel_attr      :dads_pesel, :mums_pesel

  validates :dads_pesel, :pesel => true

end
