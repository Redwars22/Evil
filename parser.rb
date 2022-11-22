require "./operators.rb"

def parseEvil(content)
    code = content
    line = 0

    while line < code.length do
        parseLine(code, line)
        line += 1
    end

    return code.push($CSS_RIGHT_BRACKET)
end

def parseLine(code, line)
    if code[line].match($SELECTOR_DEF) and code[line].strip().include?($BLOCK_BEGIN) then
        code[line][$BLOCK_BEGIN] = $CSS_LEFT_BRACKET
        return
    end

    if code[line].match($VAR_DECL) then
        tokens = code[line].split(' ')
        identifier = tokens[0]
        value = tokens[1]

        identifier[$VAR] = ""

        code[line] = "\t" + $CSS_VAR + identifier + ": " + value + ";"
        return
    end

    if code[line] == "\n" or code[line].strip == ""then
        code[line] = $CSS_RIGHT_BRACKET + "\n\n"
        return
    end

    if code[line].strip().match($ATTRIBUTE) and not code[line].strip().include?($BLOCK_BEGIN) then
        statement = code[line].split(' ')
        identifier = statement[0] + ": "
        statement[0] = identifier

        i = 1

        while i < statement.length do
            if statement[i].strip().match($VAR_RETRIEVE) then
                statement[i]["@"] = ""
                statement[i] = $CSS_VAR_FUNC + statement[i].strip() + ")"
            end

            i = i + 1
        end

        statement = statement.join('')
        code[line] = "\t" + statement + ";"
    end
end