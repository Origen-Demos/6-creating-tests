module ATDTest
  class Falcon
    include Origen::TopLevel

    def initialize(options = {})
      instantiate_pins(options)
      instantiate_registers(options)
      instantiate_sub_blocks(options)
    end

    def instantiate_pins(options = {})
      add_pin :tclk
      add_pin :tdi
      add_pin :tdo
      add_pin :tms
      add_pin :resetb
      add_pins :port_a, size: 8
    end

    def instantiate_registers(options = {})
    end

    def instantiate_sub_blocks(options = {})
      sub_block :atd, instances: 2, class_name: 'ATD',
        base_address: [0x1000_0000, 0x1000_1000]
    end
  end
end
