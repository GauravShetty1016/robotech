require_relative "../../app/components/simple_robot"

RSpec.describe Robotech::Component::SimpleRobot do
  let(:ruleset) { double(valid_position?: true) }
  subject { Robotech::Component::SimpleRobot.new(ruleset: ruleset) }

  it "Should not take any action if the place command has not been processed" do
    expect(subject).not_to receive(:place_robot)
    expect(subject).not_to receive(:move_robot)
    expect(subject.action(["move"])).to be_nil

    expect(subject).not_to receive(:place_robot)
    expect(subject).not_to receive(:turn_left)
    expect(subject.action(["left"])).to be_nil

    expect(subject).not_to receive(:place_robot)
    expect(subject).not_to receive(:turn_right)
    expect(subject.action(["right"])).to be_nil

    expect(subject).not_to receive(:place_robot)
    expect(subject).not_to receive(:print_position)
    expect(subject.action(["report"])).to be_nil
  end

  it "Should place the robot if the place command has been sent" do
    expect(subject).to receive(:place_robot).with(["0", "0", "north"]).and_call_original
    subject.action(["place", ["0", "0", "north"]])
    expect { subject.action(["report"]) }.to output("0,0,NORTH\n").to_stdout
  end

  it "Should turn the robot left every time the command is sent" do
    subject.action(["place", ["0", "0", "north"]])
    expect { subject.action(["report"]) }.to output("0,0,NORTH\n").to_stdout

    subject.action(["left"])
    expect { subject.action(["report"]) }.to output("0,0,WEST\n").to_stdout

    subject.action(["left"])
    expect { subject.action(["report"]) }.to output("0,0,SOUTH\n").to_stdout

    subject.action(["left"])
    expect { subject.action(["report"]) }.to output("0,0,EAST\n").to_stdout

    subject.action(["left"])
    expect { subject.action(["report"]) }.to output("0,0,NORTH\n").to_stdout
  end

  it "Should turn the robot right every time the command is sent" do
    subject.action(["place", ["0", "0", "north"]])
    expect { subject.action(["report"]) }.to output("0,0,NORTH\n").to_stdout

    subject.action(["right"])
    expect { subject.action(["report"]) }.to output("0,0,EAST\n").to_stdout

    subject.action(["right"])
    expect { subject.action(["report"]) }.to output("0,0,SOUTH\n").to_stdout

    subject.action(["right"])
    expect { subject.action(["report"]) }.to output("0,0,WEST\n").to_stdout

    subject.action(["right"])
    expect { subject.action(["report"]) }.to output("0,0,NORTH\n").to_stdout
  end

  it "Should move the robot one spot in the direction it is facing when move command is sent" do
    subject.action(["place", ["0", "0", "north"]])
    expect { subject.action(["report"]) }.to output("0,0,NORTH\n").to_stdout

    subject.action(["move"])
    expect { subject.action(["report"]) }.to output("0,1,NORTH\n").to_stdout

    subject.action(["right"])
    subject.action(["move"])
    expect { subject.action(["report"]) }.to output("1,1,EAST\n").to_stdout

    subject.action(["right"])
    subject.action(["move"])
    expect { subject.action(["report"]) }.to output("1,0,SOUTH\n").to_stdout

    subject.action(["right"])
    subject.action(["move"])
    expect { subject.action(["report"]) }.to output("0,0,WEST\n").to_stdout
  end

  it "Should print the position as a string to stdout" do
    subject.action(["place", ["0", "0", "north"]])
    expect { subject.action(["report"]) }.to output("0,0,NORTH\n").to_stdout
  end

  describe "invalid actions" do
    let(:ruleset) { double(valid_position?: false) }
    subject { Robotech::Component::SimpleRobot.new(ruleset: ruleset) }

    it "Should not perform action when ruleset is false" do
      subject.action(["place", ["0", "0", "north"]])
      expect(subject.action(["report"])).to be_nil
    end
  end
end
