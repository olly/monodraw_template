require "monodraw_template/version"

class MonodrawTemplate
  def initialize(source)
    @source = source
  end

  attr_reader :source

  def render(vars)
    template.call(vars)
  end

  private

  LEFT_PLACEHOLDERS = /\{\{( +)(?<name>[\w\-]+)( +)\}\}/
  RIGHT_PLACEHOLDERS = /\[\[( +)(?<name>[\w\-]+)( +)\]\]/
  CENTERED_PLACEHOLDERS = /(\s+)>>( +)(?<name>[\w\-]+)( +)<<(\s+)/


  def template
    ->(vars) {
      source.gsub!(LEFT_PLACEHOLDERS) do |placeholder|
        match = Regexp.last_match

        name = match['name'].to_sym
        size = match[0].size
        value = vars.fetch(name)

        value.ljust(size)
      end

      source.gsub!(RIGHT_PLACEHOLDERS) do |placeholder|
        match = Regexp.last_match

        name = match['name'].to_sym
        size = match[0].size
        value = vars.fetch(name)

        value.rjust(size)
      end

      source.gsub!(CENTERED_PLACEHOLDERS) do |placeholder|
        match = Regexp.last_match

        name = match['name'].to_sym
        size = match[0].size
        value = vars.fetch(name)

        value.center(size)
      end
    }
  end
end
