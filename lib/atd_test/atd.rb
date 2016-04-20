module ATDTest
  class ATD
    include Origen::Model
    include CrossOrigen

    def initialize(options = {})
      cr_import(path: "#{Origen.root}/ipxact/atd.xml")
    end
  end
end
