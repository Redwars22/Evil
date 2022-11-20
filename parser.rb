require "./operators.rb"

def parseEvil(content)
    code = content
    line = 0

    while line < code.length do
        if code[line].match($SELECTOR_DEF) then
            code[line][$BLOCK_BEGIN] = $CSS_LEFT_BRACKET
        elsif code[line].match($ATTRIBUTE) then
            attribute = code[line].strip()
            identifier = code[line].split(' ')[0]
            attribute[identifier] = identifier + ":"
            code[line] = "\t" + attribute + ";"
        end

        if code[line].match($VAR_DECL) then
            tokens = code[line].split(' ')
            identifier = tokens[0]
            value = tokens[1]

            if value.match($VAR_RETRIEVE) then
                value[$VAR] = ""
                value = $CSS_VAR_FUNC + value + ")"
            end

            identifier[$VAR] = ""

            code[line] = $CSS_VAR + identifier + ": " + value + ";"
        end

        if code[line] == "\n" then
            code[line] = $CSS_RIGHT_BRACKET + "\n\n"
        end

        line += 1
    end

    return code.push($CSS_RIGHT_BRACKET)
end