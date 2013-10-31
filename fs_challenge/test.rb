#!/usr/bin/env ruby

require 'minitest'
require 'minitest/autorun'
require_relative 'challenge'

class TestTheMap < Minitest::Test
  def setup
    @map = TheMap.new(
      "0 4 0 2 2",
      "1 4 0 5 3",
      "2 0 0 0 1",
      "2 4 0 5 2",
      "2 0 0 4 0")
  end

  def test_row_counts_for
    assert_equal [2,1,3,1,3], @map.counts_for(@map.rows)
  end

  def test_column_counts_for
    assert_equal [1,2,5,1,1], @map.counts_for(@map.columns)
  end

  def test_next_row
    assert_equal Entry.new(2, 3), @map.next_row
  end

  def test_next_column
    assert_equal Entry.new(2, 5), @map.next_column
  end

  M = TheMap::MARKER

  def test_mark
    @map.mark!
    assert_equal \
      [[0, 4, M, 2, 2],
       [1, 4, M, 5, 3],
       [2, 0, M, 0, 1],
       [2, 4, M, 5, 2],
       [2, 0, M, 4, 0]], @map.rows

    @map.mark!
    assert_equal \
      [[0, 4, M, 2, 2],
       [1, 4, M, 5, 3],
       [M, M, M, M, M],
       [2, 4, M, 5, 2],
       [2, 0, M, 4, 0]], @map.rows

    @map.mark!
    assert_equal \
      [[0, 4, M, 2, 2],
       [1, 4, M, 5, 3],
       [M, M, M, M, M],
       [2, 4, M, 5, 2],
       [M, M, M, M, M]], @map.rows

    @map.mark!
    assert_equal \
      [[M, M, M, M, M],
       [1, 4, M, 5, 3],
       [M, M, M, M, M],
       [2, 4, M, 5, 2],
       [M, M, M, M, M]], @map.rows

    assert @map.done?
  end
end
