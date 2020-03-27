require_relative "../../app/game_modes/file_input_mode"
require_relative "../../app/parsers/text_file_parser"

RSpec.describe Robotech::GameMode::FileInputMode do
  let(:board) { double(action: nil) }
  let(:board_gen) { double(new: board_gen_inst) }
  let(:board_gen_inst) { double(board: board) }
  let(:file_name) { File.dirname(__FILE__) + "/../fixtures/commands.txt" }
  let(:mode) { Robotech::GameMode::FileInputMode.new(file: file_name, board_generator: board_gen) }

  it "should call the parser for the file" do
    expect(Robotech::Parser::TextFileParser).to receive(:parse).with(file: file_name).and_call_original
    mode.start_game
  end

  it "should call the command parser for each command" do
    expect(Robotech::Parser::SimpleCommandParser).to receive(:parse).exactly(5).times.and_call_original
    mode.start_game
  end

  it "should create a new board_generator" do
    expect(board_gen).to receive(:new)
    Robotech::GameMode::FileInputMode.new(file: file_name, board_generator: board_gen)
  end

  it "should create a new board" do
    expect(board_gen_inst).to receive(:board)
    Robotech::GameMode::FileInputMode.new(file: file_name, board_generator: board_gen)
  end

  it "should call the board action method for all commands" do
    expect(board).to receive(:action).exactly(5).times
    mode.start_game
  end
end
