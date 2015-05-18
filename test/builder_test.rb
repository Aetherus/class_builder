require 'test/unit'
require 'class_builder'

class BuilderTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    spec_file = File.expand_path('../car_spec.txt', __FILE__)
    builder = ClassBuilder::Builder.new(spec_file)
    builder.build
    @car = ::Car.new
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Fake test
  def test_readers
    assert_equal @car.price, nil
    assert_equal @car.model, nil
  end

  def test_writers
    @car.model = 'Mercedes Benz'
    @car.price = 3000

    assert_equal @car.model, 'Mercedes Benz'
    assert_equal @car.price, 3000
  end

  def test_setting_values_with_wrong_type
    assert_raise do
      @car.model = 3000
    end

    assert_raise do
      @car.price = '3000'
    end
  end
end