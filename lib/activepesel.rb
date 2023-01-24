# frozen_string_literal: true

# Copyright (C) 2023
# Author: Wojciech Pasternak / voytee
# Email: wpasternak@gmail.com
# License: MIT

require 'activepesel/pesel'
require 'activepesel/pesel_attr'
require 'activepesel/personal_data'
require 'activepesel/pesel_generator'
require 'active_model/validations/pesel_validator' if defined?(ActiveModel)
