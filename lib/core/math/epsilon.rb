module Volt
  module VoltMath
    class EpsilonComputer

      def self.solve
        e = 0.5

    		while 1.0 + e > 1.0 do
    			e *= 0.5
        end

    		e
      end
    end

    class Epsilon
      @@epsilon = EpsilonComputer.solve

      def self.e
        @@epsilon
      end
    end
  end
end