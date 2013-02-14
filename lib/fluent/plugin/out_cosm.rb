require 'fluent/plugin/out_http'

class Fluent::CosmOutput < Fluent::HTTPOutput
  Fluent::Plugin.register_output('cosm', self)

  config_set_default :endpoint_url, 'http://api.cosm.com/v2/feeds/'
  config_set_default :http_method, :put

  # Cosm API key with read permission.
  config_param :api_key, :string
  # Cosm feed ID.
  config_param :feed_id, :integer, :default => nil
  # Use the tag to determine which Cosm feed to post.
  # Example:
  #
  #   config:
  #     <match cosm.*>
  #       type cosm
  #       feed_id_tag_index 1
  #     </match>
  #
  #   tag:
  #     cosm.12345
  #
  #   feed id:
  #     12345
  config_param :feed_id_tag_index, :integer, :default => nil

  def configure(conf)
    super
    if @feed_id.nil? and @feed_id_tag_index.nil?
      raise Fluent::ConfigError, 'specify either `feed_id` or `feed_id_tag_index`'
    end
  end

  def format_url(tag, time, record)
    URI::join(@endpoint_url, get_feed_id(tag)).to_s
  end

  def get_feed_id(tag)
    if not @feed_id_tag_index.nil?
      parts = tag.split '.'
      if parts.size > @feed_id_tag_index
        feed_id = parts[@feed_id_tag_index]
        return Integer(feed_id) if feed_id =~ /^[0-9]+$/
      end
    end
    return @feed_id
  end

  def set_body(req, tag, time, record)
    datastreams = record.map do |k,v|
      {:current_value => v, :id => k.downcase.sub(' ', '-')}
    end
    set_json_body(req, {:datastreams => datastreams})
  end

  def set_header(req, tag, time, record)
    req['X-ApiKey'] = @api_key
  end
end
