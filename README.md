# Numbertext

From Numbers to Number Names\
This is a [soros programming language](https://numbertext.github.io/) ruby interpreter.\
Soros programming language is based on regular expressions

```ruby
  2300.to_word # => two thousand three hundred
  7654.to_word # => seven thousand six hundred fifty-four
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'numbertext'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install numbertext

## Usage

Default locale is English

```ruby
2300.to_word # => two thousand three hundred
```

Set other language

```ruby
2300.to_word(locale: :ru) # => две тысячи триста
2300.to_word(locale: :pl) # => dwa tysiące trzysta
2300.to_word(locale: :de) # => zweitausenddreihundert
2300.to_word(locale: :it) # => duemilatrecento

```

## Currently supported locales
Afrikaans\
Български\
Català\
Česky\
Dansk\
Deutsch\
Deutsch (CH)\
Ελληνικά\
English\
English (GB)\ 
English (IN)\
Esperanto\
Español\
Eesti\
Suomi\
Français\
Français (BE)\
Français (CH)\
Galego\
עברית\
Hrvatski\
Magyar\
Bahasa Indonesia\
Íslenska\
Italiano\
日本語\
한국어 (KR)\
한국어 (KP)\
Luxembourgish\
Lietuvių\
Latviešu\
Bahasa Melayu\
Nederlands\
Bokmål\
Nynorsk\
Polski\
Português\
Português (BR)\
Română\
Русский\
Srpski\
Slovenščina\
Shqip\
Српски\
Svenska\
ไทย\
Türkçe\
Українська\
Tiếng Việt\
大写\
Roman*\
花碼*

*Old numeral systems (extended for large numbers) – Old Hungarian, Roman and Suzhou numerals

## Useful links

* [Home of Soros Programming Language](https://numbertext.github.io/)
* [Authors and contributors of NUMBERTEXT development
](https://github.com/Numbertext/libnumbertext/blob/master/AUTHORS)

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/zumkorn/numbertext](https://github.com/zumkorn/numbertext).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).\
You can read the license for locale files and soros programming language [here](https://numbertext.github.io/).