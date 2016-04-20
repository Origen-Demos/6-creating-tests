Flow.create do |options|

  options[:instances].times do |i|
    func "atd_ramp_#{i}" 
  end

end
