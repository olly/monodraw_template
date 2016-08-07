require "monodraw_template/version"

class MonodrawTemplate
  class MissingVariableError < RuntimeError; end
  class VariableTooLongError < RuntimeError; end

  PLACEHOLDERS = {
    /\{\{( *)(?<name>[\w\-]+)( *)\}\}/ => ->(value, size) { value.ljust(size) },
    /(\s+)>>( *)(?<name>[\w\-]+)( *)<<(\s+)/ => ->(value, size) { value.center(size) },
    /\[\[( *)(?<name>[\w\-]+)( *)\]\]/ => ->(value, size) { value.rjust(size) },
  }

  class Placeholder
    def initialize(name, offset, size, replacement)
      @name, @offset, @size, @handler = name, offset, size, replacement
    end

    attr_reader :name, :offset, :size, :handler
  end

  def initialize(source)
    @source = source
    @template = compile(source)
  end

  def render(vars)
    template.call(vars)
  end

  private

  attr_reader :template

  def compile(source)
    placeholders = PLACEHOLDERS.each.with_object([]) do |(matcher, replacement), memo|
      source.scan(matcher) do
        match = Regexp.last_match
        name = match['name'].to_sym
        offset = match.begin(0)
        size = match[0].size
        memo << Placeholder.new(name, offset, size, replacement)
      end
    end

    ->(vars) {
      source.dup.tap do |output|
        placeholders.each do |placeholder|
          value = vars.fetch(placeholder.name) { raise MissingVariableError, "missing variable: '#{placeholder.name}'" }
          value = placeholder.handler.call(value, placeholder.size)
          if value.size > placeholder.size
            raise VariableTooLongError, "variable '#{placeholder.name}' is too long. maximum: #{placeholder.size}"
          end

          output[placeholder.offset, placeholder.size] = value
        end
      end
    }
  end
end
