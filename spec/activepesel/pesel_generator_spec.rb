# frozen_string_literal: true

RSpec.describe Activepesel::PeselGenerator do
  describe '.generate_one' do
    subject(:pesel) { described_class.generate_one(**options) }

    context 'with date_of_birth not covered by PESEL system' do
      let(:options) { { sex: 1, date_of_birth: '3033-01-01' } }

      specify { expect { pesel }.to raise_exception(ArgumentError) }
    end

    context 'with sex not covered by PESEL system' do
      let(:options) { { sex: 3, date_of_birth: '1982-06-01' } }

      specify { expect { pesel }.to raise_exception(ArgumentError) }
    end

    let(:options) { { sex: sex, date_of_birth: date_of_birth } }
    { 1 => 'men', 2 => 'women' }.each do |sex_code, sex_name|
      context "for #{sex_name}" do
        let(:sex) { sex_code }

        context 'for year 18XX' do
          let(:date_of_birth) { '1801-12-12' }
          specify { expect(pesel.valid?).to be_truthy }
          specify { expect(pesel.date_of_birth.to_s).to eq(date_of_birth) }
          specify { expect(pesel.sex).to eq(sex) }
        end

        context 'for year 19XX' do
          let(:date_of_birth) { '1901-12-12' }
          specify { expect(pesel.valid?).to be_truthy }
          specify { expect(pesel.date_of_birth.to_s).to eq(date_of_birth) }
          specify { expect(pesel.sex).to eq(sex) }
        end

        context 'for year 20XX' do
          let(:date_of_birth) { '2001-12-12' }
          specify { expect(pesel.valid?).to be_truthy }
          specify { expect(pesel.date_of_birth.to_s).to eq(date_of_birth) }
          specify { expect(pesel.sex).to eq(sex) }
        end

        context 'for year 21XX' do
          let(:date_of_birth) { '2101-12-12' }
          specify { expect(pesel.valid?).to be_truthy }
          specify { expect(pesel.date_of_birth.to_s).to eq(date_of_birth) }
          specify { expect(pesel.sex).to eq(sex) }
        end

        context 'for year 22XX' do
          let(:date_of_birth) { '2201-12-12' }
          specify { expect(pesel.valid?).to be_truthy }
          specify { expect(pesel.date_of_birth.to_s).to eq(date_of_birth) }
          specify { expect(pesel.sex).to eq(sex) }
        end
      end
    end
  end

  describe '.generate_all' do
    subject(:pesels) { described_class.generate_all(sex: 1, date_of_birth: '1983-06-04') }

    specify { expect(pesels.count).to eq(5000) }
    specify { expect(pesels.map(&:valid?).uniq.first).to be_truthy }
    specify { expect(pesels.map(&:date_of_birth).uniq.first.to_s).to eq('1983-06-04') }
    specify { expect(pesels.map(&:sex).uniq.first).to eq(1) }
  end
end
