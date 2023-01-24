# frozen_string_literal: true

RSpec.describe Activepesel::Pesel do
  subject(:pesel) { described_class.new(pesel_number) }
  describe '#valid?' do
    context 'with valid pesel number' do
      let(:pesel_number) { '88061654752' }
      it 'returns true' do
        expect(pesel.valid?).to be_truthy
      end
    end

    context 'with invalid pesel number' do
      let(:pesel_number) { '88061654751' }
      it 'returns false' do
        expect(pesel.valid?).to be_falsey
      end
    end

    context 'with completely gibberish pesel number' do
      let(:pesel_number) { 'sdfljklsrtbr' }
      it 'returns false' do
        expect(pesel.valid?).to be_falsey
      end
    end
  end

  describe '.generate' do
    it 'responds to the generate method' do
      expect(described_class).to respond_to :generate
    end
  end

  describe '#sex' do
    subject { pesel.sex }

    context 'with invalid pesel' do
      let(:pesel_number) { '88061654751' }
      it { is_expected.to eq(9) }
    end

    context 'with valid pesel' do
      context 'with male sex' do
        let(:pesel_number) { '10240474019' }

        it { is_expected.to eq(1) }
      end

      context 'with female sex' do
        let(:pesel_number) { '10240428209' }

        it { is_expected.to eq(2) }
      end
    end
  end

  describe '#date_of_birth' do
    subject { pesel.date_of_birth }

    context 'with invalid pesel' do
      let(:pesel_number) { '88061654751' }
      it { is_expected.to be_nil }
    end

    context 'with valid pesel' do
      context 'with year 18XX' do
        let(:pesel_number) { '01852014407' }
        it { is_expected.to eq(Date.new(1801, 5, 20)) }
      end

      context 'with year 19XX' do
        let(:pesel_number) { '88061654752' }
        it { is_expected.to eq(Date.new(1988, 6, 16)) }
      end

      context 'with year 20XX' do
        let(:pesel_number) { '10240428209' }
        it { is_expected.to eq(Date.new(2010, 4, 4)) }
      end

      context 'with year 21XX' do
        let(:pesel_number) { '34433088405' }
        it { is_expected.to eq(Date.new(2134, 3, 30)) }
      end

      context 'with year 22XX' do
        let(:pesel_number) { '22682152604' }
        it { is_expected.to eq(Date.new(2222, 8, 21)) }
      end
    end
  end
end
