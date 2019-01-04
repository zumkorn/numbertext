require "./lib/soros"

module Numbertext
  def to_word(locale: "en")
    locale = locale.to_s if locale.class == Symbol
    program = program(locale)
    number = self.to_s
    Soros.new(locale, program).run(number)
  end

  private

  def program(locale)
    file = File.open("./lib/locales/#{locale}.sor")
    file.read
  end
end

class Integer
  include Numbertext
end

class Float
  include Numbertext
end
