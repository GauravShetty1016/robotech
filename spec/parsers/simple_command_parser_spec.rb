require_relative "../../app/parsers/simple_command_parser"

RSpec.describe Robotech::Parser::SimpleCommandParser, "@parse" do
  subject { Robotech::Parser::SimpleCommandParser }

  it "Should respond to parse" do
    expect(subject).to respond_to :parse
  end

  it "should return nil if command param is nil" do
    expect(subject.parse(nil)).to be_nil
  end

  it "should return nil if command param is an empty string" do
    expect(subject.parse("")).to be_nil
  end

  it "should return action if action has only one part" do
    expect(subject.parse("move")).to eq(["move"])
  end

  it "should return action and parameters if action has 2 parts" do
    expect(subject.parse("place 0,0,North")).to eq(["place", ["0", "0", "north"]])
  end

  it "should return remove extra spaces in single part commands" do
    expect(subject.parse("move ")).to eq(["move"])
  end

  it "should return remove extra spaces in two part commands" do
    expect(subject.parse("place  0, 0, north ")).to eq(["place", ["0", "0", "north"]])
  end

  it "should convert all commands to downcase" do
    expect(subject.parse("MOVE")).to eq(["move"])
    expect(subject.parse("PLACE 0,0,NORTH")).to eq(["place", ["0", "0", "north"]])
  end
end
