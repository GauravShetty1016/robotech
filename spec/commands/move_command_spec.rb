require_relative "../../app/commands/move_command"

RSpec.describe Robotech::Commands::MoveCommand do
  it "should return false when the position is invalid" do
    command = Robotech::Commands::MoveCommand.new(command: ["move"], position: nil, orientations: ["a"], ruleset: double({ valid_position?: true }))
    expect(command.perform).to be false
  end

  it "should return false when the command is not move" do
    command = Robotech::Commands::MoveCommand.new(command: ["moving"], position: nil, orientations: ["a"], ruleset: double({ valid_position?: true }))
    expect(command.perform).to be false
  end

  it "should raise an error when the command is nil" do
    expect { Robotech::Commands::MoveCommand.new(command: nil, position: { x: 1, y: 2, facing_index: 1 }, orientations: ["a"], ruleset: double({ valid_position?: true })) }.to raise_error(ArgumentError)
  end

  it "should return false if the move is invalid" do
    command = Robotech::Commands::MoveCommand.new(command: ["move"], position: { x: 1, y: 2, facing_index: 1 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: false }))
    expect(command.perform).to be false
  end

  it "should move in the correct direction if the move is valid" do
    command = Robotech::Commands::MoveCommand.new(command: ["move"], position: { x: 1, y: 2, facing_index: 0 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.perform).to eq({ x: 1, y: 3, facing_index: 0 })
    expect(command.position).to eq({ x: 1, y: 3, facing_index: 0 })

    command = Robotech::Commands::MoveCommand.new(command: ["move"], position: { x: 1, y: 2, facing_index: 1 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.perform).to eq({ x: 2, y: 2, facing_index: 1 })
    expect(command.position).to eq({ x: 2, y: 2, facing_index: 1 })

    command = Robotech::Commands::MoveCommand.new(command: ["move"], position: { x: 1, y: 2, facing_index: 2 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.perform).to eq({ x: 1, y: 1, facing_index: 2 })
    expect(command.position).to eq({ x: 1, y: 1, facing_index: 2 })

    command = Robotech::Commands::MoveCommand.new(command: ["move"], position: { x: 1, y: 2, facing_index: 3 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.perform).to eq({ x: 0, y: 2, facing_index: 3 })
    expect(command.position).to eq({ x: 0, y: 2, facing_index: 3 })
  end
end
