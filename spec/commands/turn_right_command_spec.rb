require_relative "../../app/commands/turn_right_command"

RSpec.describe Robotech::Commands::TurnRightCommand do
  it "should return false if the action is not valid" do
    command = Robotech::Commands::TurnRightCommand.new(command: ["move"], position: { x: 1, y: 2, facing_index: 0 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.perform).to be false
  end

  it "should return false if the position is blank" do
    command = Robotech::Commands::TurnRightCommand.new(command: ["right"], position: nil, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.perform).to be false
  end

  it "should return false if the orientations are nil" do
    command = Robotech::Commands::TurnRightCommand.new(command: ["right"], position: { x: 1, y: 2, facing_index: 0 }, orientations: nil, ruleset: double({ valid_position?: true }))
    expect(command.perform).to be false
  end

  it "should return false if the position facing index is nil or absent" do
    command = Robotech::Commands::TurnRightCommand.new(command: ["right"], position: { x: 1, y: 2, facing_index: nil }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.perform).to be false

    command = Robotech::Commands::TurnRightCommand.new(command: ["right"], position: { x: 1, y: 2 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.perform).to be false
  end

  it "should return the correct position if the params are correct" do
    command = Robotech::Commands::TurnRightCommand.new(command: ["right"], position: { x: 1, y: 2, facing_index: 0 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.perform).to eq({ x: 1, y: 2, facing_index: 1 })
    expect(command.position).to eq({ x: 1, y: 2, facing_index: 1 })

    command = Robotech::Commands::TurnRightCommand.new(command: ["right"], position: { x: 1, y: 2, facing_index: 3 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.perform).to eq({ x: 1, y: 2, facing_index: 0 })
    expect(command.position).to eq({ x: 1, y: 2, facing_index: 0 })
  end

  it "should return the default valid action" do
    command = Robotech::Commands::TurnRightCommand.new(command: ["right"], position: { x: 1, y: 2, facing_index: 3 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.valid_action).to eq("right")
  end

  it "should return new valid action when the action is changed" do
    command = Robotech::Commands::TurnRightCommand.new(command: ["right"], position: { x: 1, y: 2, facing_index: 3 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    command.valid_action = "rightward"
    expect(command.valid_action).to eq("rightward")
  end

  it "should process the new command when the action is changed" do
    command = Robotech::Commands::TurnRightCommand.new(command: ["rightward"], position: { x: 1, y: 2, facing_index: 3 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    command.valid_action = "rightward"
    expect(command.valid_action).to eq("rightward")
    expect(command.perform).to eq({ x: 1, y: 2, facing_index: 0 })
    expect(command.position).to eq({ x: 1, y: 2, facing_index: 0 })
  end

  it "should process the new command when the action is changed in the initializer" do
    command = Robotech::Commands::TurnRightCommand.new(command: ["rightward"], valid_action: "rightward", position: { x: 1, y: 2, facing_index: 3 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.valid_action).to eq("rightward")
    expect(command.perform).to eq({ x: 1, y: 2, facing_index: 0 })
    expect(command.position).to eq({ x: 1, y: 2, facing_index: 0 })
  end
end
