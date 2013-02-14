# fluent-plugin-out-cosm

[Fluentd][1] output plugin for sending logs to [Cosm].

  [1]: http://fluentd.org/
  [2]: http://cosm.com

## Configs

    <match *>
      type cosm
      api_key   YOUR_API_KEY_WITH_READ_PERMISSION
      feed_id   YOUR_COSM_FEED_ID
    </match>

    <match *>
      type cosm
      api_key   YOUR_API_KEY_WITH_READ_PERMISSION
      feed_id_tag_index 1  # use the second tag component as feed ID
    </match>


## License

Apache License, Version 2.0
