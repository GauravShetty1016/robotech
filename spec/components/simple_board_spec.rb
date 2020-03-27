require_relative "../../app/components/simple_board"

RSpec.describe Robotech::Component::SimpleBoard do
  let(:robot_inst) { double(action: nil) }
  let(:robot) { double(new: robot_inst) }
  let(:ruleset_inst) { double() }
  let(:ruleset) { double(new: ruleset_inst) }
  subject { Robotech::Component::SimpleBoard.new(robot: robot, ruleset: ruleset) }

  it "should create a new ruleset" do
    expect(ruleset).to receive(:new).with(boundaries: { width: 5, height: 5 })
    Robotech::Component::SimpleBoard.new(ruleset: ruleset)
  end

  it "should create a new robot" do
    expect(robot).to receive(:new).with(ruleset: ruleset_inst)
    Robotech::Component::SimpleBoard.new(robot: robot, ruleset: ruleset)
  end

  it "should accept dimension options" do
    expect(ruleset).to receive(:new).with(boundaries: { width: 10, height: 10 })
    Robotech::Component::SimpleBoard.new(ruleset: ruleset, options: { width: 10, height: 10 })
  end

  it "should respond to action" do
    expect(subject).to respond_to(:action)
  end

  it "should pass the action to robot" do
    expect(robot_inst).to receive(:action).with("sample")
    subject.action("sample")
  end
end
