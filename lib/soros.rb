NUMBER_TEXT = '"([a-z][-a-z]* )?0+(0|[1-9]\\d*)" $(\\\1\\\2);"(.*)(.+)(.*)" \\\1\\\2\\\3;".*.*"'
META = '\\"$()|#;[]'
ENC = ''
FUNCPAT = /(\|?(\()+)?(\|?\(([^\(\)]*)\)\|?)(\)+\|?)?/
MATCHLINE = /^\s*(\"[^\"]*\"|[^\s]*)\s*(.*[^\s])?\s*$/

class Soros
  attr_accessor :program, :lang
  attr_reader :lang, :funcpat, :meta, :enc, :lines

  def initialize(lang, program)
    @lang = lang
    @program = prepare_program(program)
    @lines = prepare_lines
  end

  def run(data)
    data = _run(tr(data, META, ENC, ''), true, true)
    tr(data, ENC, META, '')
  end

  private

  def prepare_program(program)
    soros_program = program
    soros_program = '__numbertext__;' + soros_program unless soros_program =~ /__numbertext__/
    soros_program = soros_program.gsub('__numbertext__', NUMBER_TEXT)
    soros_program = tr(soros_program, META, ENC, "\\")
    soros_program = soros_program.gsub(/(^|[\n;])([^\n;#]*#[^\n]*\[[\]:[^\n:\]]*:][^\n]*)/, '$1#$2')
                        .gsub(Regexp.new('(^|[\n;])#([^\n;#]*#[^\n]*\[[\]:' + @lang.tr('_', '-') + ':][^\n]*)'), '$1$2')
    soros_program
  end

  def _run(data, b, e)
    @lines.each do |l|
      if (!((!b && l[:b]) || (!e && l[:e])))
        m = data.match(l[:pat])
        if m
          repl = l[:repl].gsub("$", "\\")
          s = data.gsub(l[:pat], repl)
          n = s.match(FUNCPAT)
          while n
            bb = false
            ee = false
            index = s.index(FUNCPAT)
            if(n[3][0] == '|' || n[0][0] == "|")
              bb = true
            elsif  (index == 0)
              bb = b
            end
            if (n[3][n[0].length - 1] == '|')
              ee = true
            elsif (index + n[0].length == s.length)
              ee = e
            end
            s = s[0, index + (n[1] ? n[1].length : 0)] +
                _run(n[4], bb, ee) + s[index + (n[1] ? n[1].length : 0) +
                                           n[3].length, s.length]
            n = s.match(FUNCPAT)
          end
          return s;
        end
      end
    end
    return '';
  end

  def linetype(regex, repl, b, e)
    { pat: regex, repl: repl, b: b, e: e }
  end

  def strip(st, ch)
    return '' if !st
    st.gsub(/^#{ch}+/, '').gsub(Regexp.new("#{ch}+$"), '')
  end

  def tr(text, chars, chars2, delim)
    (0..chars.length - 1).each do |i|
      s = delim + chars[i]
      while text.index(s) && text.index(s) > 0 do
        text = text.gsub(s, chars2[i])
      end
    end
    text
  end

  def tr_program
    @program = tr(@program, META, ENC, "\\")
  end

  def switch_program
    @program = @program.gsub(/(^|[\n;])([^\n;#]*#[^\n]*\[[\]:[^\n:\]]*:][^\n]*)/, '$1#$2')
                   .gsub(Regexp.new('(^|[\n;])#([^\n;#]*#[^\n]*\[[\]:' + @lang.gsub('_', '-') + ":][^\n]*)"), '$1$2')
  end

  def prepare_lines
    l_array = @program.gsub(/(#[^\n]*)?(\n|$)/, ';').split(';')
    prefix = ''
    lines_array = []
    l_array.each do |l|
      macro = l.match(/== *(.*[^ ]?) ==/)
      if macro
        prefix = macro[0]
        next
      end
      s = l.scan(MATCHLINE)[0]
      if (prefix != "" && l != "" && s[0])
        s1 = strip(s[0], '"')
        empty = s1 == ""
        start = !empty && s1[0] == "^"
        s[1] = "" unless s[1]
        l2 = '"' + (start ? '^' : '') + prefix + (empty ? '' : ' ') + s1.gsub('^^', '') + '" ' + s[1]
        s = l2.scan(MATCHLINE)[0]
      end
      if s
        s[0] = strip(s[0], '"')
        unless s[1]
          s[1] = ''
        else
          s[1] = strip(s[1], '"')
        end
        b = /^\^/ =~ s[0] ? true : false
        e = /\$$/ =~ s[0] ? true : false
        line = linetype(Regexp.new('^' + s[0].gsub('^^', '').gsub('$$', '') + '$'),
                        s[1].gsub(/\\n/, '\n')
                            .gsub(/[\[]\$(\d\d?|\([^\)]+\))/, '$(|$\1')
                            .gsub(/[\[]([^\$\[\\]*)\$(\d\d?|\([^\)]+\))/, '$(\1$\2')
                            .gsub(/\]$/, '|)')
                            .gsub(/]/, ')')
                            .gsub(/(\$\d|\))\|\$/, '\1|$')
                            .gsub(/\$/, '')
                            .gsub(/\\0/, '$&')
                            .gsub(/\\(\d)/, '$\1')
                            .gsub(/(\d)/, '($\1)'),
                        b, e)
        lines_array << line
      end
    end
    lines_array
  end
end