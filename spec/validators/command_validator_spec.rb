require_relative "../../app/validators/command_validator"

RSpec.describe Robotech::Validator::CommandValidator, "@validate" do
  let(:validator) { Robotech::Validator::CommandValidator }

  it "should respond to validate" do
    expect(validator).to respond_to :validate
  end

  it "should return false if command is nil" do
    expect(validator.validate(nil)).to eq(false)
  end

  it "should return false if command is blank" do
    expect(validator.validate("")).to eq(false)
  end

  it "should return false if command is blank array" do
    expect(validator.validate([])).to eq(false)
  end

  it "should return false if command is blank string" do
    expect(validator.validate([""])).to eq(false)
  end

  it "should return true if command is move, left, right or report" do
    expect(validator.validate(["move"])).to eq(true)
    expect(validator.validate(["left"])).to eq(true)
    expect(validator.validate(["right"])).to eq(true)
    expect(validator.validate(["report"])).to eq(true)
  end

  it "should return false if command is not valid" do
    expect(validator.validate(["hoho"])).to eq(false)
  end

  it "should return true if command is a valid place command" do
    expect(validator.validate(["place", [0, 0, "north"]])).to eq true
  end

  it "should return false if command is an invalid place command" do
    expect(validator.validate(["place", ["a", 0, "north"]])).to eq false
    expect(validator.validate(["place", [0, "b", "north"]])).to eq false
    expect(validator.validate(["place", [0, 0, "northe"]])).to eq false
  end
end
