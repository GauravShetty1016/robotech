require_relative "../../app/game_modes/interactive_mode"

RSpec.describe Robotech::GameMode::InteractiveMode do
  let(:board) { double(action: nil) }
  let(:board_gen) { double(new: board_gen_inst) }
  let(:board_gen_inst) { double(board: board) }
  let(:mode) { Robotech::GameMode::InteractiveMode.new(board_generator: board_gen) }

  it "should call the command parser for each command" do
    expect(Robotech::Parser::SimpleCommandParser).to receive(:parse).and_call_original
    mode.send(:run_command, "move")
  end

  it "should call the validator for each command" do
    expect(Robotech::Validator::CommandValidator).to receive(:validate).and_call_original
    mode.send(:run_command, "move")
  end

  it "should create a new board_generator" do
    expect(board_gen).to receive(:new)
    Robotech::GameMode::InteractiveMode.new(board_generator: board_gen)
  end

  it "should create a new board" do
    expect(board_gen_inst).to receive(:board)
    Robotech::GameMode::InteractiveMode.new(board_generator: board_gen)
  end

  it "should print invalid command if a command is invalid" do
    expect { mode.send(:run_command, "moving") }.to output("Invalid Command\n").to_stdout
  end
end
