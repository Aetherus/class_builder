module ClassBuilder
  class Attributes
    attr_reader :name, :type, :constraints

    def initialize(name, type)
      @name = name
      @type = type.constantize
      @constraints = []
    end

    def build(klass)
      return build_reader(klass), build_writer(klass)
    end

    private
    def build_reader(klass)
      klass.class_eval <<-EOS, __FILE__, __LINE__ + 1
        attr_reader :#{name}
      EOS
    end

    def build_writer(klass)
      klass.class_eval <<-EOS, __FILE__, __LINE__ + 1
        def #{name}=(value)
          raise "Attribute type mismatch: #{name}: Expect a #{type.name} but is given a \#{value.class.name}" unless value.is_a?(#{type.name})
          #{constraints.map(&:build).join("\r\n")}
          @#{name} = value
        end
      EOS
    end
  end
end