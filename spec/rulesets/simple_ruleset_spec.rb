require_relative "../../app/rulesets/simple_ruleset"

RSpec.describe Robotech::Ruleset::SimpleRuleset, "#valid_position?" do
  subject { Robotech::Ruleset::SimpleRuleset.new(boundaries: { width: 5, height: 5 }) }
  it "should respond to valid_position?" do
    expect(subject).to respond_to :valid_position?
  end

  it "should return true if position is nil" do
    expect(subject.valid_position?(nil)).to eq true
  end

  it "should return true if position is valid" do
    expect(subject.valid_position?({ x: 1, y: 1 })).to eq true
  end

  it "should return false if position is invalid" do
    expect(subject.valid_position?({ x: -1, y: 0 })).to eq false
    expect(subject.valid_position?({ x: 0, y: -1 })).to eq false
    expect(subject.valid_position?({ x: 5, y: 0 })).to eq false
    expect(subject.valid_position?({ x: 0, y: 5 })).to eq false
  end
end
