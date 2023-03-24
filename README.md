# AdmqrKnife

通过第三方转发统计信息给毛驴短链, 这样就可以做到不用用户访问访问, 将用户的信息直接转发即可

特别适合与做漏斗

比如曝光页面用毛驴做了统计

就可以在注册的时候再次发起一次统计, 即可得出曝光转化比

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'admqr_knife'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install admqr_knife

## Usage

### 命令行方式

`admqr_visit record 标签名称 -t CLIENT_KEY`

更多参数可以使用 `admqr_visit help record` 进行查看


### gem 集成

1. 在 rails 里 initializers 中配置

```ruby
AdmqrKnife.init(CLIENT_KEY)
```

2. 在需要记录的地方使用如下语法记录

```ruby
AdmqrKnife.visit unique_code: "唯一标记",
                       ua: ua, # UA , 可不传
                       referer: referer, # 来自于 , 可不传
                       tag: tag, # 分组名 , 可不传
                       new_to_visit: new_to_visit,  # 是否是今日首次访问 , 可不传, 默认是
                       remote_ip: remote_ip # "用户IP"
```

### 直接发请求或集成第三方

这种使用方式不需要安装这个gem

```bash
curl -X POST \
  https://www.maolvdl.com/apic/v1/api/knifes/statis \
  -H 'Content-Type: application/json' \
  -d '{
	"client_key": "你的CLIENT_KEY",
	"unique_code": "自己取的唯一标志",
        "tag": "分组名, 可以不传",
	"extra": {a: 1, b:2},  一层hash 值, 可不传
	"client_ua": "用户UA, 可以不传",
	"referer": "来自于, 可以不传",
    "new_to_visit": 是否是首次访问 true or false, 可以不传, 默认为true
    "remote_ip": '用户的ip, 可以不传'
}'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/admqr_knife. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AdmqrKnife project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/admqr_knife/blob/master/CODE_OF_CONDUCT.md).
