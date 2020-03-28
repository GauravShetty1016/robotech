require_relative "../../app/commands/turn_left_command"

RSpec.describe Robotech::Commands::TurnLeftCommand do
  it "should return false if the action is not valid" do
    command = Robotech::Commands::TurnLeftCommand.new(command: ["move"], position: { x: 1, y: 2, facing_index: 0 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.perform).to be false
  end

  it "should return false if the position is blank" do
    command = Robotech::Commands::TurnLeftCommand.new(command: ["left"], position: nil, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.perform).to be false
  end

  it "should return false if the orientations are nil" do
    command = Robotech::Commands::TurnLeftCommand.new(command: ["left"], position: { x: 1, y: 2, facing_index: 0 }, orientations: nil, ruleset: double({ valid_position?: true }))
    expect(command.perform).to be false
  end

  it "should return false if the position facing index is nil or absent" do
    command = Robotech::Commands::TurnLeftCommand.new(command: ["left"], position: { x: 1, y: 2, facing_index: nil }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.perform).to be false

    command = Robotech::Commands::TurnLeftCommand.new(command: ["left"], position: { x: 1, y: 2 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.perform).to be false
  end

  it "should return the correct position if the params are correct" do
    command = Robotech::Commands::TurnLeftCommand.new(command: ["left"], position: { x: 1, y: 2, facing_index: 0 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.perform).to eq({ x: 1, y: 2, facing_index: 3 })
    expect(command.position).to eq({ x: 1, y: 2, facing_index: 3 })

    command = Robotech::Commands::TurnLeftCommand.new(command: ["left"], position: { x: 1, y: 2, facing_index: 3 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.perform).to eq({ x: 1, y: 2, facing_index: 2 })
    expect(command.position).to eq({ x: 1, y: 2, facing_index: 2 })
  end

  it "should return the default valid action" do
    command = Robotech::Commands::TurnLeftCommand.new(command: ["left"], position: { x: 1, y: 2, facing_index: 3 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.valid_action).to eq("left")
  end

  it "should return new valid action when the action is changed" do
    command = Robotech::Commands::TurnLeftCommand.new(command: ["left"], position: { x: 1, y: 2, facing_index: 3 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    command.valid_action = "leftward"
    expect(command.valid_action).to eq("leftward")
  end

  it "should process the new command when the action is changed" do
    command = Robotech::Commands::TurnLeftCommand.new(command: ["leftward"], position: { x: 1, y: 2, facing_index: 3 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    command.valid_action = "leftward"
    expect(command.valid_action).to eq("leftward")
    expect(command.perform).to eq({ x: 1, y: 2, facing_index: 2 })
    expect(command.position).to eq({ x: 1, y: 2, facing_index: 2 })
  end

  it "should process the new command when the action is changed in the initializer" do
    command = Robotech::Commands::TurnLeftCommand.new(command: ["leftward"], valid_action: "leftward", position: { x: 1, y: 2, facing_index: 3 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.valid_action).to eq("leftward")
    expect(command.perform).to eq({ x: 1, y: 2, facing_index: 2 })
    expect(command.position).to eq({ x: 1, y: 2, facing_index: 2 })
  end
end
