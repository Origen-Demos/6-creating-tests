module ATDTest
  class Eagle
    include Origen::TopLevel

    def initialize(options = {})
      instantiate_pins(options)
      instantiate_registers(options)
      instantiate_sub_blocks(options)
    end

    def instantiate_pins(options = {})
      add_pin :swd_clk
      add_pin :swd_dio
      add_pin :tclk
      add_pin :resetb
      add_pins :port_a, size: 8
    end

    def instantiate_registers(options = {})
    end

    def instantiate_sub_blocks(options = {})
      sub_block :atd, instances: 2, class_name: 'ATD'
    end
  end
end
