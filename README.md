# Activepesel

A simple PESEL (polish personal ID number) validator for Rails 3. Compatible with Ruby 1.8.7, 1.9.2 and
Rubinius 1.2.2.

Activepesel library is available as a gem. In your Gemfile add:

```ruby
gem 'activepesel'
```

#In your model:

```ruby
class User < ActiveRecord::Base
  attr_accessible :dads_pesel, :mums_pesel
  
  # this will give the access to methods: 
  # dads_pesel_personal_data, mums_pesel_personal_data
  pesel_attr :dads_pesel, :mums_pesel

  # keep in mind that pesel validator is not performing a presence test
  # so you need another (standard) validation for this one
  validates :dads_pesel, :presence => true
  validates :dads_pesel, :pesel    => true
  validates :mums_pesel, :pesel    => true

end
```

# Activepesel::PersonalData object

When using ```attr_pesel :name_of_attr``` in your model you will get new instance method available: ```name_of_attr_personal_data```.

The method returns ```Activepesel::PersonalData``` object which has the following attributes:

```ruby
date_of_birth:Date
sex:Integer
```

Sex attribute can take 3 values. 1 - for men, 2 - for women, 9 - not applicable ([ISO/IEC 5218](http://en.wikipedia.org/wiki/ISO/IEC_5218))

For the invalid PESEL numbers the ```date_of_birth``` attribute is set to ```nil``` and the ```sex``` is 9 - not applicable.

# Using Activepesel outside ActiveModel / ActiveRecord models.

You can use it like in the given example

```
pesel = Activepesel::Pesel.new("82060202039")
pesel.valid? => true
pesel.get_personal_data => Activepesel::PersonalData(...)
```  




