#!/usr/bin/env ruby

class TheMap
  def initialize(*lines)
    @rows = lines.map do |line|
      line.split(" ").map(&:to_i)
    end
    @results = []
  end

  def done?
    counts_for(rows).inject(&:+) == 0
  end

  def mark!
    if next_column > next_row
      mark_column!(next_column.index)
    else
      mark_row!(next_row.index)
    end
  end

  def solve!
    until done?
      mark!
    end
  end

  def next_row
    best_entry counts_for(rows)
  end

  def next_column
    best_entry counts_for(columns)
  end

  attr_reader :rows, :results

  def columns
    columns = @rows.count.times.map {[]}
    @rows.each do |row|
      row.each_with_index do |cell, index|
        columns[index] << cell
      end
    end
    columns
  end

  MARKER = Float::INFINITY

  def mark_column!(next_index)
    results << "Column #{next_index} repaired"
    @rows.each do |row|
      row[next_index] = MARKER
    end
  end

  def mark_row!(next_index)
    results << "Row #{next_index} repaired"
    @rows[next_index] = Array.new(@rows.count, MARKER)
  end

  def counts_for(source)
    source.map do |entry|
      entry.select {|cell| cell <= 0}.count
    end
  end

  def best_entry(source_counts)
    best_entry = Entry.new(-1,-1)
    source_counts.each_with_index do |source_count, index|
      best_entry = Entry.new(index, source_count) if best_entry < source_count
    end
    best_entry
  end

  def report
    puts *results
    rows.each do |row|
      row.each do |cell|
        print "#{cell == MARKER ? 'X' : cell} "
      end
      puts
    end
  end
end

class Entry < Struct.new(:index, :count)
  alias_method :to_i, :count

  def ==(value)
    self.index == value.index && self.count == value.count
  end

  def <(value)
    self.to_i < value.to_i
  end

  def >(value)
    self.to_i > value.to_i
  end
end

if $0 == __FILE__
  puts "Enter the data yo!"
  count = gets.to_i
  lines = count.times.map { gets }

  the_map = TheMap.new(*lines)
  the_map.solve!
  the_map.report
end
