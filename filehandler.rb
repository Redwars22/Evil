def getSourceFromFile(filename)
    file = File.new(filename, "r")
    return file.readlines
end

def generateCSSOutput(filename, content)
    filename[".evil"] = ".css"
    file = File.new("css/" + filename, "w")

    line = 0

    while line < content.length do
        puts(content[line])
        file.puts(content[line])
        line += 1
    end

    file.close
end