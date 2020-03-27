require_relative "../../app/parsers/text_file_parser"

RSpec.describe Robotech::Parser::TextFileParser do
  subject { Robotech::Parser::TextFileParser }
  let(:file_name) { File.dirname(__FILE__) + "/../fixtures/commands.txt" }

  it "should respond to parse method" do
    expect(subject).to respond_to :parse
  end

  describe "@parse" do
    it "should accept a block" do
      parser = double(subject)
      proc = Proc.new { }
      expect(parser).to receive(:parse) do |&block|
        expect(proc).to be(block)
      end
      parser.parse(file: file_name, &proc)
    end

    it "should read all the commands in the file" do
      commands = ["move", "left", "right", "place 0,0,north", "piece"]
      index = 0

      subject.parse(file: file_name) do |command|
        expect(command).to eq commands[index]
        index += 1
      end

      expect(index).to eq commands.length
    end

    it "should return nil if no block is given" do
      expect(subject.parse(file: file_name)).to be_nil
    end
  end
end
