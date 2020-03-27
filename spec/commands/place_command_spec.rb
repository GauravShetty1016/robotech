require_relative "../../app/commands/place_command"

RSpec.describe Robotech::Commands::PlaceCommand do
  it "should return false is the action is not valid" do
    command = Robotech::Commands::PlaceCommand.new(command: ["move"], position: nil, ruleset: double({ valid_position?: true }))
    expect(command.perform).to be false
  end

  it "should return false if the params are nil" do
    command = Robotech::Commands::PlaceCommand.new(command: ["place"], position: nil, ruleset: double({ valid_position?: true }))
    expect(command.perform).to be false
  end

  it "should return false if the params length is not 3" do
    command = Robotech::Commands::PlaceCommand.new(command: ["place", [0]], position: nil, ruleset: double({ valid_position?: true }))
    expect(command.perform).to be false
  end

  it "should return false if the params are not valid" do
    command = Robotech::Commands::PlaceCommand.new(command: ["place", [0, "x", "north"]], orientations: ["north", "east", "south", "west"], position: nil, ruleset: double({ valid_position?: true }))
    expect(command.perform).to be false

    command = Robotech::Commands::PlaceCommand.new(command: ["place", ["y", 0, "north"]], orientations: ["north", "east", "south", "west"], position: nil, ruleset: double({ valid_position?: true }))
    expect(command.perform).to be false

    command = Robotech::Commands::PlaceCommand.new(command: ["place", [0, 0, "northward"]], orientations: ["north", "east", "south", "west"], position: nil, ruleset: double({ valid_position?: true }))
    expect(command.perform).to be false
  end

  it "should return false if the position is not valid" do
    command = Robotech::Commands::PlaceCommand.new(command: ["place", [0, -1, "north"]], orientations: ["north", "east", "south", "west"], position: nil, ruleset: double({ valid_position?: false }))
    expect(command.perform).to be false
  end

  it "should return the default valid action" do
    command = Robotech::Commands::PlaceCommand.new(command: ["place", [0, 0, "north"]], position: nil, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.valid_action).to eq("place")
  end

  it "should return new valid action when the action is changed" do
    command = Robotech::Commands::PlaceCommand.new(command: ["place", [0, 0, "north"]], position: nil, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    command.valid_action = "placing"
    expect(command.valid_action).to eq("placing")
  end

  it "should process the new command when the action is changed" do
    command = Robotech::Commands::PlaceCommand.new(command: ["placing", [0, 0, "north"]], position: nil, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    command.valid_action = "placing"
    expect(command.valid_action).to eq("placing")
    expect(command.perform).to eq({ x: 0, y: 0, facing_index: 0 })
    expect(command.position).to eq({ x: 0, y: 0, facing_index: 0 })
  end

  it "should process the new command when the action is changed in the initializer" do
    command = Robotech::Commands::PlaceCommand.new(command: ["placing", [0, 0, "north"]], valid_action: "placing", position: nil, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.valid_action).to eq("placing")
    expect(command.perform).to eq({ x: 0, y: 0, facing_index: 0 })
    expect(command.position).to eq({ x: 0, y: 0, facing_index: 0 })
  end

  it "should return the correct position if the command is valid" do
    command = Robotech::Commands::PlaceCommand.new(command: ["place", [0, 0, "north"]], position: nil, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.perform).to eq({ x: 0, y: 0, facing_index: 0 })
    expect(command.position).to eq({ x: 0, y: 0, facing_index: 0 })
  end
end
