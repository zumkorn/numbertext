require 'spec_helper'

RSpec.describe "Numbertext" do
  describe 'russian specific rules' do
    it '2300 - две тысячи триста' do
      expect(2300.to_word(locale: :ru)).to eql('две тысячи триста')
    end

    it '448302399948372384 - четыреста сорок восемь квадриллионов триста два триллиона триста девяносто девять миллиардов девятьсот сорок восемь миллионов триста семьдесят две тысячи триста восемьдесят четыре' do
      expect(448302399948372384.to_word(locale: :ru)).to eql('четыреста сорок восемь квадриллионов триста два триллиона триста девяносто девять миллиардов девятьсот сорок восемь миллионов триста семьдесят две тысячи триста восемьдесят четыре')
    end

    it '999999999999999999999999999 - девятьсот девяносто девять септиллионов девятьсот девяносто девять секстилионов девятьсот девяносто девять квинтиллионов девятьсот девяносто девять квадриллионов девятьсот девяносто девять триллионов девятьсот девяносто девять миллиардов девятьсот девяносто девять миллионов девятьсот девяносто девять тысяч девятьсот девяносто девять' do
      expect(999999999999999999999999999.to_word(locale: :ru)).to eql('девятьсот девяносто девять септиллионов девятьсот девяносто девять секстилионов девятьсот девяносто девять квинтиллионов девятьсот девяносто девять квадриллионов девятьсот девяносто девять триллионов девятьсот девяносто девять миллиардов девятьсот девяносто девять миллионов девятьсот девяносто девять тысяч девятьсот девяносто девять')
    end
  end

  describe 'english specific rules' do
    it '2300 - two thousand three hundred' do
      expect(2300.to_word(locale: :en)).to eql('two thousand three hundred')
    end

    it '448302399948372384 - efour hundred forty-eight quadrillion, three hundred two trillion, three hundred ninety-nine billion, nine hundred forty-eight million, three hundred seventy-two thousand, three hundred eighty-four' do
      expect(448302399948372384.to_word(locale: :en)).to eql('four hundred forty-eight quadrillion, three hundred two trillion, three hundred ninety-nine billion, nine hundred forty-eight million, three hundred seventy-two thousand, three hundred eighty-four')
    end

    it '999999999999999999999999999 - nine hundred ninety-nine septillion, nine hundred ninety-nine sextillion, nine hundred ninety-nine quintillion, nine hundred ninety-nine quadrillion, nine hundred ninety-nine trillion, nine hundred ninety-nine billion, nine hundred ninety-nine million, nine hundred ninety-nine thousand, nine hundred ninety-nine' do
      expect(999999999999999999999999999.to_word(locale: :en)).to eql('nine hundred ninety-nine septillion, nine hundred ninety-nine sextillion, nine hundred ninety-nine quintillion, nine hundred ninety-nine quadrillion, nine hundred ninety-nine trillion, nine hundred ninety-nine billion, nine hundred ninety-nine million, nine hundred ninety-nine thousand, nine hundred ninety-nine')
    end
  end
end