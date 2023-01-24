## 0.2.0 (Jan, 25th 2023)
 - Replace tests with specs
 - Stop including `Activepesel::PeselAttr` `to ActiveRecord::Base`, it should be included explicitly to a model instead
 - Replace `Activepesel::Pesel#generate` with `Activepesel::Pesel#generate_one` and `Activepesel::Pesel#generate_all`
 - Add Ruby 3.X support
 - Fix styling and add rubocop
 - Reduce dependencies