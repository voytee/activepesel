# frozen_string_literal: true

RSpec.describe Activepesel::PeselAttr do
  let(:dummy) do
    Class.new do
      include Activepesel::PeselAttr

      pesel_attr :pesel_a, :pesel_b

      attr_reader :pesel_a, :pesel_b

      def initialize(pesel_a, pesel_b)
        @pesel_a = pesel_a
        @pesel_b = pesel_b
      end
    end
  end

  subject(:dummy_obj) { dummy.new(pesel_a, pesel_b) }

  let(:pesel_a) { '88061654752' }
  let(:pesel_b) { '88061654752' }

  it 'returns extracted personal data' do
    expect(dummy_obj.pesel_a_personal_data).to be_kind_of(Activepesel::PersonalData)
    expect(dummy_obj.pesel_b_personal_data).to be_kind_of(Activepesel::PersonalData)
  end
end
