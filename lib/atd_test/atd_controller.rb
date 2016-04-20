module ATDTest
  class ATDController
    include Origen::Controller

    def convert(channel)
      ss "Performing an ATD conversion on channel #{channel}"
      sc1.adch.write!(channel)
      tester.wait time_in_us: 100
      sc1.coco.assert!(1)
      r.d # Return the result bits
    end
  end
end
