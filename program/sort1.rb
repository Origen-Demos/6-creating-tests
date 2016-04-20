Flow.create do

  # This test will do something
  #
  # * Some bullets
  # * About this test
  test :test_a, bin: 3, softbin: 100, number: 1000

  test :test_b, bin: 3, softbin: 101, number: 1010, id: :test1

  test :test_c, if_failed: :test1

  if_job :p1 do
    test :p1_test1, id: :p11
    test :p1_test2, id: :p12
    test :p1_test3, if_all_failed: [:p11, :p12]
    if_enable :bitmap do
      test :bitmap_test
    end
  end

  if_job :p2 do
    test :p2_test1, id: :p21
    test :p2_test2, id: :p22
    test :p2_test3, if_any_passed: [:p21, :p22]
  end

  group "200Mhz Tests", id: :g200 do
    test :test200_1
    test :test200_2
    test :test200_3
  end

  group "100Mhz Tests", if_failed: :g200, id: :g100 do
    test :test100_1, bin: 5
    test :test100_2, bin: 5
    test :test100_3, bin: 5
  end

  if_job :p2 do
    import "atd_tests", instances: 4
  end

  pass 2, if_ran: :g100

  pass 1


end
