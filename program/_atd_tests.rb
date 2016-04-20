Flow.create do |options|

  options[:instances].times do |i|
    test "atd_ramp_#{i}" 
  end

end
