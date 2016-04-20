module ATDTest
  class FalconController
    include Origen::Controller
    include OrigenNexus

    # Hook the Nexus module into the register API, any register read
    # requests will use the Nexus by default
    def read_register(reg, options = {})
      nexus.read_register(reg, options)
    end

    # As above for write requests
    def write_register(reg, options = {})
      nexus.write_register(reg, options)
    end

    def startup(options)
      pp 'Enter test mode' do
        tester.set_timeset('func_25mhz', 40)   # Where 40 is the period in ns
        pin(:tclk).drive!(1)
        pin(:resetb).drive!(1)
        nexus.jtag.write_ir(0x5, size: 8)
        nexus.jtag.write_dr(0x25, size: 16)
        tester.wait time_in_us: 100
      end
    end

    def shutdown(options)
      pp 'Reset the device' do
        pin(:resetb).drive!(0)
        pin(:tclk).drive!(0)
      end
    end
  end
end
