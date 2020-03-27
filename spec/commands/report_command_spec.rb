require_relative "../../app/commands/report_command"

RSpec.describe Robotech::Commands::ReportCommand do
  it "should return false if the action is not valid" do
    command = Robotech::Commands::ReportCommand.new(command: ["move"], position: { x: 1, y: 2, facing_index: 0 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.perform).to be false
  end

  it "should return false if the position is blank" do
    command = Robotech::Commands::ReportCommand.new(command: ["report"], position: nil, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.perform).to be false
  end

  it "should return false if the orientations do not have the appropriate value for provided facing index" do
    command = Robotech::Commands::ReportCommand.new(command: ["report"], position: { x: 1, y: 2, facing_index: 5 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.perform).to be false
  end

  it "should return false if the orientations are nil" do
    command = Robotech::Commands::ReportCommand.new(command: ["report"], position: { x: 1, y: 2, facing_index: 0 }, orientations: nil, ruleset: double({ valid_position?: true }))
    expect(command.perform).to be false
  end

  it "should return false if the position facing index is nil or absent" do
    command = Robotech::Commands::ReportCommand.new(command: ["report"], position: { x: 1, y: 2, facing_index: nil }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.perform).to be false

    command = Robotech::Commands::ReportCommand.new(command: ["report"], position: { x: 1, y: 2 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect(command.perform).to be false
  end

  it "should output current position" do
    command = Robotech::Commands::ReportCommand.new(command: ["report"], position: { x: 1, y: 2, facing_index: 1 }, orientations: ["north", "east", "south", "west"], ruleset: double({ valid_position?: true }))
    expect { command.perform }.to output("1,2,EAST\n").to_stdout
  end
end
