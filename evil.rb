require "./def.rb"
require "./filehandler.rb"
require "./grammar.rb"
require "./parser.rb"

def Evil()
    command = ""
    filename = ""

    puts $EVIL_WELCOME

    while command != "exit" do
        print $EVIL_COMMAND
        command = gets

        if(command.match($EVIL_FILE)) then
            content = getSourceFromFile(command.strip)

            generateCSSOutput(command.strip, parseEvil(content))
        end
    end
end

Evil()