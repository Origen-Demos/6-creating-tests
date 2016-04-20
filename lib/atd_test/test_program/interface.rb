module ATDTest
  module TestProgram
    class Interface
      include OrigenTesters::ProgramGenerators

      def func(name, options={})
        name = test_name(name, options)
        # Create the test
        if tester.j750?
          ins = test_instances.functional(name)
        else
          ins = test_suites.add(name, options)
          ins.test_method = test_methods.ac_tml.functional_test(options)
        end
        apply_conditions(ins, options)
        # Create the pattern set entry
        pname = pattern_name(name, options)
        if tester.j750?
          patset_name = "#{name}_pset"
          pat = patsets.add(patset_name, pattern: "patterns/ATD/#{pname}.PAT")
          ins.pattern = patset_name
        else
          ins.pattern = pname
        end

        # Insert the test into the flow
        test(ins, options)
      end

      def para(name, options={})
        name = test_name(name, options)
        # Create the test
        if tester.j750?
          ins = test_instances.ppmu(name, options)
        else
          ins = test_suites.add(name, options)
          ins.test_method = test_methods.dc_tml.general_pmu(options)
        end
        apply_conditions(ins, options)
        # Create the pattern set entry
        if tester.j750?
          patset_name = "#{name}_pset"
          pat = patsets.add(patset_name, pattern: "patterns/ATD/#{pattern_name(name, options)}.PAT")
          ins.pattern = patset_name
        else
        end

        # Insert the test into the flow
        test(ins, options)
      end

      def apply_conditions(ins, options={})
        if tester.j750?
          ins.ac_category = "Spec"
          ins.ac_selector = "Default"
          ins.dc_category = "Spec"
          if options[:vdd]
            if options[:vdd] == :max
              ins.dc_selector = "Max"
            elsif options[:vdd] == :min
              ins.dc_selector = "Min"
            elsif options[:vdd] == :nom
              ins.dc_selector = "Default"
            else
              fail "Unknown vdd selector: #{options[:vdd]}"
            end
          else
            ins.dc_selector = "Default"
          end
          ins.time_sets = "Tim"
          ins.pin_levels = "Lvl"
        else
          ins.level_equation = 14
          ins.level_spec = 1
          ins.level_set = 1
        end
      end

      def test_name(name, options={})
        "atd_#{name}"
      end

      def pattern_name(name, options={})
        "#{name}_pattern"
      end
    end
  end
end
