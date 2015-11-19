require "factory/version"

module Factory

  class Model

    def self.new(*args, &block)

      name = args.shift if args[0].is_a?(String)

      Class.new do

        args.each do |arg|
          attr_accessor arg 
        end

        define_method :initialize do |*values|
          @values = values
          @pairs = args.zip(values).to_h
          args.each_with_index do |arg, index| 
            instance_variable_set("@#{arg}", values[index])
          end
        end

        define_method :== do |other|
          self.values == other.values
        end
        alias_method :eql?, :==

        define_method :[] do |index|
          index.is_a?(Symbol) ? self.send(index) : @values[index]
        end

        define_method :each do |&block|
          @values.each(&block)
        end

        define_method :each_pair do |&block|
          @pairs.each(&block)
        end

        define_method :hash do 
          @pairs
        end
        alias_method :to_h, :hash

        define_method :inspect do
          @pairs.map { |name, value| "#{name}=#{value}" }.join(', ')
        end
        alias_method :to_s, :inspect

        define_method :members do
        end

        define_method :select do |&block|
          @values.select(&block)
        end

        define_method :size do

        end

        define_method :values do
          @values
        end
        alias_method :to_a, :values

      end
    end

    class_eval(&block) if block_given?
  end
end
