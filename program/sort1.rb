Flow.create interface: "ATDTest::TestProgram::Interface" do

  # This func will do something
  #
  # * Some bullets
  # * About this test
  func :test_a, bin: 3, softbin: 100, number: 1000, vdd: :max

  func :test_b, bin: 3, softbin: 101, number: 1010, id: :test1

  func :test_c, if_failed: :test1

  func :test_d

  if_job :p1 do
    para :p1_test1, id: :p11, lo_limit: 10.mV, hi_limit: 20.mV
    func :p1_test2, id: :p12
    func :p1_test3, if_all_failed: [:p11, :p12]
    if_enable :bitmap do
      func :bitmap_test
    end
  end

  if_job :p2 do
    func :p2_test1, id: :p21, vdd: :min
    func :p2_test2, id: :p22
    func :p2_test3, if_any_passed: [:p21, :p22]
  end

  group "200Mhz Tests", id: :g200 do
    func :test200_1
    func :test200_2
    func :test200_3
  end

  group "100Mhz Tests", if_failed: :g200, id: :g100 do
    func :test100_1, bin: 5
    func :test100_2, bin: 5
    func :test100_3, bin: 5
  end

  if_job :p2 do
    import "atd_tests", instances: 4
  end

  pass 2, if_ran: :g100

  pass 1


end
