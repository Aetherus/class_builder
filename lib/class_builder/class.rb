module ClassBuilder
  class Class
    attr_reader :name, :attributes

    def initialize(name)
      @name = name
      @attributes = []
    end

    def build
      klass = ::Class.new
      attributes.each { |attr| attr.build(klass) }
      Object.const_set(name, klass)
    end
  end
end