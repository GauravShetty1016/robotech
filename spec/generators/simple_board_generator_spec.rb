require_relative "../../app/board_generators/simple_board_generator"

RSpec.describe Robotech::BoardGenerator::SimpleBoardGenerator do
  let(:robot) { double() }
  let(:board_inst) { double() }
  let(:board) { double(new: board_inst) }
  subject { Robotech::BoardGenerator::SimpleBoardGenerator.new(board: board, robot: robot) }

  it "should respond to board" do
    expect(subject).to respond_to(:board)
  end

  it "should create a new board and send the robot as a parameter" do
    expect(board).to receive(:new).with(robot: robot)
    subject.board
  end
end
