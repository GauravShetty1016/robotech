# Robotech Player Guide

## How to run the program

There are 2 modes to the game. A file mode and an interactive mode. To get started

1. Run chmod +x bin/robotech
2. To see the help run the following: `./bin/robotech -h`
3. To run the program in file mode: `./bin/robotech -f FILENAME`. A sample file has been attached so to run that `./bin/robotech -f commands.txt`
4. In file mode all the commands in the provided file are run at once and the output is printed to console.
5. To run the program in interactive mode: `./bin/robotech -i` or just `./bin/robotech`
6. In interactive mode you are provided with a command prompt. You can enter the commands one at a time. Type `exit` to exit or just press `ctrl+c`.

## Structure

The whole project is split into multiple folders under the app folder:

1. validators: Contains all the validation logic for the commands provided.
2. rulesets: Contains the rules of the game. In this case that the robot cannot fall off the board.
3. parsers: Contains all the parsers for the app. Text file parser to read the text file and command parser to break down the command.
4. game_modes: Contains the logic to start the respective game mode.
5. components: Contains the components of the actual game and its base classes.
6. board_generators: Contains logic to choose and generate the correct board for the game.

## Testing

Rspec 3.6 was used to create the test suite. Files are available in the spec folder. To use it:

1. Run `bundle install` to install the gem dependencies.
2. Run `rspec` to run the whole test suite.
