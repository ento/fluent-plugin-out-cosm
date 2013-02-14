require 'fluent/test'
require 'fluent/plugin/out_cosm'


class CosmOutputTest < Test::Unit::TestCase
  CONFIG = %[
    api_key API_KEY
    feed_id 12345
  ]

  CONFIG_TAG_INDEX = %[
    api_key API_KEY
    feed_id_tag_index 1
  ]

  CONFIG_FEED_ID_AND_TAG_INDEX = %[
    api_key API_KEY
    feed_id 12345
    feed_id_tag_index 1
  ]

  def setup
    Fluent::Test.setup
  end

  def create_driver(conf=CONFIG, tag='test.metrics')
    Fluent::Test::OutputTestDriver.new(Fluent::CosmOutput, tag).configure(conf)
  end

  def test_feed_id_normal
    d = create_driver
    assert_equal 12345, d.instance.get_feed_id('tag.foo.bar')
  end

  def test_feed_id_tag_index
    d = create_driver CONFIG_TAG_INDEX
    assert_equal 234, d.instance.get_feed_id('tag.234.bar')
    assert_equal nil, d.instance.get_feed_id('tag')

    d = create_driver CONFIG_FEED_ID_AND_TAG_INDEX
    assert_equal 12345, d.instance.get_feed_id('tag')
  end
end
