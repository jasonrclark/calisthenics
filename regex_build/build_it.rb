#!/usr/bin/env ruby

require 'minitest'
require 'minitest/autorun'

class Regexp
  def self.build(*args)
    values = []
    args = args.map do |arg|
      if arg.respond_to?(:to_a)
        values += arg.to_a
      else
        values << arg
      end
    end
    Regexp.new("^(#{values.join("|")})$")
  end
end

class RegexpTest < MiniTest::Test
  def test_array
    arr = Regexp.build([1,2,4])
    assert("1" =~ arr)
  end

  def test_lucky
    lucky = Regexp.build(3, 7)
    assert ("7"  =~ lucky)
    refute ("13" =~ lucky)
    assert ("3"  =~ lucky)
  end

  def test_month
    month = Regexp.build(1..12)
    refute ("0"  =~ month)
    assert ("1" =~ month)
    assert ("12"  =~ month)
  end

  def test_day
    day = Regexp.build(1..31)
    assert ("6"  =~ day)
    assert ("16" =~ day)
    refute ("Tues" =~ day)
  end

  def test_year
    year = Regexp.build(98, 99, 2000..2005)
    refute ("04"  =~ year)
    assert ("2004" =~ year)
    assert ("99" =~ year)
  end
  #
  #puts
  #num = Regexp.build(0..1_000_000)
  #p ("-1" =~ num)
end
