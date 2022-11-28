require "./operators.rb"

$mixins = {}
$isParsingMixin = false
$currentMixinName = ""
$currentMixinAttr = []

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

    if code[line] == "\n" or code[line].strip == "" and code[line + 1].match($SELECTOR_DEF) then
        code[line] = $CSS_RIGHT_BRACKET + "\n\n"
        return
    end

    if code[line].match($MIXIN_SPREAD) then
        identifier = code[line].strip()
        identifier[$MIXIN_SPREAD_OP] = ""
        code[line] = $mixins[identifier]
        return
    end

    if code[line].match($MIXIN_DECL) then
        identifier = code[line].strip
        identifier[" " + $MIXIN_BEGIN] = ""
        puts identifier
        $isParsingMixin = true
        $currentMixinName = identifier
        return
    end

    if $isParsingMixin and not (code[line].strip() == $MIXIN_END) then
        $currentMixinAttr.push(code[line].strip)
        return
    end

    if code[line].strip() == $MIXIN_END then
        $isParsingMixin = false

        i = 0

        while i < $currentMixinAttr.length do
            statement = $currentMixinAttr[i].split(' ')
            identifier = statement[0] + ": "
            statement[0] = identifier
    
            token = 1
    
            while token < statement.length do
                if statement[token].strip().match($VAR_RETRIEVE) then
                    statement[token]["@"] = ""
                    statement[token] = $CSS_VAR_FUNC + statement[token].strip() + ")"
                end
    
                if statement[token].strip() == "!" then
                    statement[token]["!"] = " !important"
                end
    
                token = token + 1
            end
    
            statement = statement.join('')
            $currentMixinAttr[i] = "\t" + statement + ";"

            i = i + 1
        end

        $mixins[$currentMixinName] = $currentMixinAttr

        $currentMixinAttr = []
        $currentMixinName = ""

        puts $mixins

        return
    end

    if code[line].match($MEDIA_QUERY) then
        code[line]["?"] = "@media"
        code[line][$BLOCK_BEGIN] = $CSS_LEFT_BRACKET
        return
    end

    if code[line].strip() == "?" then
        code[line]["?"] = $CSS_RIGHT_BRACKET
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

            if statement[i].strip() == "!" then
                statement[i]["!"] = " !important"
            end

            i = i + 1
        end

        statement = statement.join('')
        code[line] = "\t" + statement + ";"
        return
    end
end