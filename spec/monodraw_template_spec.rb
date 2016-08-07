require 'spec_helper'

describe MonodrawTemplate do
  it 'has a version number' do
    expect(MonodrawTemplate::VERSION).not_to be nil
  end

  describe "#render" do
    it "renders multiple placeholders of the same type" do
      template = MonodrawTemplate.new("{{a}} {{b}} {{c}}")
      expect(template.render(a: 'A', b: 'B', c: 'C')).to eql("A     B     C    ")
    end

    it "raises a MissingVariableError if template expects variable which isn't supplied" do
      template = MonodrawTemplate.new("{{a}}")

      expect {
        template.render({})
      }.to raise_error(MonodrawTemplate::MissingVariableError, "missing variable: 'a'")
    end
  end
end
