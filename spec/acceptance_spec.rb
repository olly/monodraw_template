require 'spec_helper'
require 'pathname'

RSpec.describe "acceptance" do
  specify "renders left, centered & right justified placeholders" do
    path = Pathname.new(__dir__).join('fixtures', 'template.txt')
    template = MonodrawTemplate.new(path.read)

    expected = "" +
    "                                                                      \n" +
    "  ┌──────────────────┐    ┌──────────────────┐    ┌──────────────────┐\n" +
    "  │                  │    │                  │    │                  │\n" +
    "  │LEFT              │    │      CENTER      │    │             RIGHT│\n" +
    "  │                  │    │                  │    │                  │\n" +
    "  └──────────────────┘    └──────────────────┘    └──────────────────┘"

    expect(template.render(left: 'LEFT', center: 'CENTER', right: 'RIGHT')).to eql(expected)
  end
end
