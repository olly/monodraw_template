# MonodrawTemplate

[Monodraw](http://monodraw.helftone.com) is a useful Mac application for drawing ASCII diagrams. This gem provides a micro templating language which respects whitespace, and allows for left and right justification along with centering of a variable within it's surrounding whitespace.

## Usage

**Template:**
```
┌────────────────────────────┐
│      >> page_title <<      │
├────────────────────────────┤
│Logged in:  {{li}} users    │──┬──┬────────────────────────┐
│Logged out: {{lo}} users    │  │  │                        │
└────────────────────────────┘  │  │                        │
                                │  │                        │
          ┌─────────────────────┘  │                        │
          │                        │                        │
          ▼                        ▼                        ▼
┌───────────────────┐    ┌───────────────────┐    ┌───────────────────┐
│             Search│    │             Browse│    │            Log Out│
│            [[sp]]%│    │            [[bp]]%│    │           [[lop]]%│
└───────────────────┘    └───────────────────┘    └───────────────────┘
```

```ruby
require 'monodraw_template'

source = File.read('examples/flow.txt')
template = MonodrawTemplate.new(source)
template.render({
  page_title: 'Homepage',
  li: '2,000',
  lo: '10,000',
  sp: '20',
  bp: '75',
  lop: '5'
})
```

**Output:**
```
┌────────────────────────────┐
│          Homepage          │
├────────────────────────────┤
│Logged in:  2,000  users    │──┬──┬────────────────────────┐
│Logged out: 10,000 users    │  │  │                        │
└────────────────────────────┘  │  │                        │
                                │  │                        │
          ┌─────────────────────┘  │                        │
          │                        │                        │
          ▼                        ▼                        ▼
┌───────────────────┐    ┌───────────────────┐    ┌───────────────────┐
│             Search│    │             Browse│    │            Log Out│
│                20%│    │                75%│    │                 5%│
└───────────────────┘    └───────────────────┘    └───────────────────┘
```

### Operators

```
{{ name }} - left justifies the value
[[ name ]] - right justifies the value
>> name << - centers the value, including the surrounding whitespace
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'monodraw_template'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install monodraw_template

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/monodraw_template. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

