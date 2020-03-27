require_relative "../app/robotech_cli"
require_relative "../app/game_modes/file_input_mode"
require_relative "../app/game_modes/interactive_mode"

RSpec.describe Robotech::CLI do
  it "Should respond to start" do
    expect(Robotech::CLI).to respond_to :start
  end

  describe "#play file mode" do
    let(:mode) { double(start_game: nil) }
    subject { Robotech::CLI.new({ file: "filename" }) }

    it "Should call the file input mode when the option is a file" do
      expect(Robotech::GameMode::FileInputMode).to receive(:new).with({ file: "filename" })
      subject.play
    end

    it "Should call start game on file input mode instance when the option is a file" do
      allow(Robotech::GameMode::FileInputMode).to receive(:new).and_return(mode)
      expect(mode).to receive(:start_game)
      subject.play
    end
  end

  describe "#play interactive mode" do
    let(:mode) { double(start_game: nil) }
    subject { Robotech::CLI.new({ interactive: true }) }

    it "Should call the interactive mode when the option is interactive" do
      expect(Robotech::GameMode::InteractiveMode).to receive(:new)
      subject.play
    end

    it "Should call start game on interactive mode instance when the option is interactive" do
      allow(Robotech::GameMode::InteractiveMode).to receive(:new).and_return(mode)
      expect(mode).to receive(:start_game)
      subject.play
    end
  end

  describe "#play interactive mode" do
    subject { Robotech::CLI.new({ other: true }) }

    it "Should return nil when the option is invalid" do
      expect(subject.play).to be_nil
    end
  end
end
