#!/usr/bin/env ruby

require 'minitest'
require 'minitest/autorun'


class Repulsion
  def initialize(pt1, pt2)
    @pt1 = pt1.split(" ").map {|v| v.to_f}
    @pt2 = pt2.split(" ").map {|v| v.to_f}
  end

  def calculate()
    delta_x = @pt1[1] - @pt2[1]
    delta_y = @pt1[2] - @pt2[2]
    distance = (delta_x ** 2 + delta_y ** 2)
    (@pt1[0] * @pt2[0]) / distance
  end
end

class RepulsionTests < MiniTest::Test
  def test_input1
    result = Repulsion.new("1 -5.2 3.8", "1 8.7 -4.1").calculate
    assert_in_delta 0.0039, result, 0.0001
  end

  def test_input2
    result = Repulsion.new("4 0.04 -0.02", "4 -0.02 -0.03").calculate
    assert_in_delta 4324.3279, result, 0.0001
  end
end
