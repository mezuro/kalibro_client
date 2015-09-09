module RangeMethods
  def range
    @range ||= Range.new(beginning, self.end, exclude_end: true)
  end

  def beginning=(value)
    @beginning = (value == "-INF") ? -Float::INFINITY : value.to_f
  end

  def end=(value)
    @end = (value == "INF") ? Float::INFINITY : value.to_f
  end
end

