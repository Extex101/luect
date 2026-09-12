luect = {} -- Luanti Emoji, Colors, and Through tags

local colESC = core.get_color_escape_sequence

local function isHex(hex)
    return type(hex) == "string" and (hex:find("%#%x%x%x%x%x%x") or hex:find("%x%x%x%x%x%x"))
end

local function hexToRgb(hex)
    if type(hex) == "table" and hex.r and hex.g and hex.b then
        hex = hex
    elseif not isHex(hex) then
        return {r=0, g=0, b=0}
    end
    return {
        r=tonumber(hex:sub(2,3),16),
        g=tonumber(hex:sub(4,5),16),
        b=tonumber(hex:sub(6,7),16)
    }
end

local function lerp(a, b, t) return a + (b - a) * t end

local function lerp_color(from, to, i)
    from = hexToRgb(from)
    to = hexToRgb(to)
    local newColor = {
        r = math.floor(lerp(from.r, to.r, i)),
        g = math.floor(lerp(from.g, to.g, i)),
        b = math.floor(lerp(from.b, to.b, i))
    }
    return string.format("#%02x%02x%02x", newColor.r, newColor.g, newColor.b)
end

function luect.lerp_colors(colors, t)
    if #colors == 1 then
        return colors[1]
    elseif #colors == 2 then
        return lerp_color(colors[1], colors[2], t)
    end
    if t <= 0 then
        return colors[1]
    elseif t >= 1 then
        return colors[#colors]
    end

    local position = t * (#colors - 1)
    local index = math.floor(position)
    local m = position - index
    return lerp_color(colors[index + 1], colors[index + 2], m)
end


-- like core.colorize() but with a gradient of #colors between the start and end of the string
function luect.gradient_colorize(colors, message)
    local new_string = ""
    for i = 1, #message do
        local t = (i-1)/(#message-1)
        local col = luect.lerp_colors(colors, t)
        local hex = string.format("#%02x%02x%02x", col.r, col.g, col.b)
        new_string = new_string..colESC(hex) .. message:sub(i,i)
    end
    return new_string..colESC("#ffffff")
end

luect.color_tags = {
    red = "#ff0000",
    orange = "#ff8000",
    yellow = "#ffff00",
    green = "#00ff00",
    lime = "#00FF99",
    cyan = "#00ffff",
    blue = "#0000ff",
    purple = "#5D00A0",
    violet = "#9021FF",
    pink = "#FF55AA",
    white = "#ffffff",
    silver = "#909090",
    grey = "#505050",
    black = "#000000"
}

luect.special_character_tags = {
    four_pointed_star = "✦",
    four_pointed_star_empty = "✧",
    star4 = "✦",
    star4_empty = "✧",
    five_pointed_star = "★",
    five_pointed_star_empty = "☆",
    star = "★",
    star_empty = "☆",
    star5 = "★",
    star5_empty = "☆",
    six_pointed_star = "✴",
    star6 = "✴",
    eight_spoked_asterisk = "✳",
    asterisk8 = "✳",
    sparkle = "❇",
    sun = "☼",
    suit_heart = "♥",
    heart_empty = "♡",
    suit_heart_empty = "♡",
    suit_spade = "♠",
    suit_spade_empty = "♤",
    suit_club = "♣",
    suit_club_empty = "♧",
    suit_diamond = "♦",
    suit_diamond_empty = "♢",
    check = "✔",
    cross = "✘",
    x = "✖",
    X = "✖",
    box_x = "╳",
    arrow_up = "↑",
    arrow_up_right = "↗",
    arrow_right = "→",
    arrow_down_right = "↘",
    arrow_down = "↓",
    arrow_down_left = "↙",
    arrow_left = "←",
    arrow_up_left = "↖",
    arrow_up_down = "↕",
    arrow_left_right = "↔",
    arrow_continue = "➡",
    arrow_turn_right = "↪",
    arrow_turn_left = "↩",
    male = "♂",
    female = "♀",
    smile = "☻",
    smile_empty = "☺",
    quarter_note = "♩",
    eigth_note = "♪",
    beamed_eight_notes = "♫",
    beamed_sixteenth_notes = "♬",
    flat = "♭",
    natural = "♮",
    sharp = "♯",
    snowflake = "❄",
    airplane = "✈",
    hotspring = "♨",
    peace_hand = "✌",
    v = "✌",
    writing = "✍",
    point_left = "☜",
    point_right = "☞",
    telephone = "☎",
    telephone_empty = "☏",
    phone = "☎",
    phone_empty = "☏",
    scissors = "✂",
    pencil = "✏",
    lower_right_pencil = "✎",
    upper_right_pencil = "✐",
    pen = "✒",
    mail = "✉",
    envelope = "✉",
    letter = "✉",
    star_of_david = "✡",
    crucifix = "✝",
    christian = "✝",
    trademark = "™",
    registered = "®",
    copyright = "©",
    minus = "−",
    divide = "÷",
    multiply = "×",
    not_equal = "≠",
    less_or_equal = "≤",
    greater_or_equal = "≥",
    ["/="] = "≠",
    ["~="] = "≠",
    ["!="] = "≠",
    ["<="] = "≤",
    [">="] = "≥",
    div = "÷",
    mult = "×",
    less_or_equal_to = "≤",
    greater_or_equal_to = "≥",
    less_than_or_equal = "≤",
    greater_than_or_equal = "≥",
    less_than_or_equal_to = "≤",
    greater_than_or_equal_to = "≥",
    heavy_exclamation = "❢",
    heavy_heart_exclamation = "❣",
    heart = "❤",
    heart_sideways = "❥",
    rotated_heart = "❥",
    floral_heart = "❦",
    floral_heart_sideways = "❧",
    rotated_floral_heart = "❧",
    bean_left = "ɞ",
    bean_right = "ʚ",
    white_pawn = "♙",
    white_king = "♔",
    white_queen = "♕",
    white_rook = "♖",
    white_bishop = "♗",
    white_knight = "♘",
    black_pawn = "♟",
    black_king = "♚",
    black_queen = "♛",
    black_rook = "♜",
    black_bishop = "♝",
    black_knight = "♞",
    chess_pawn = "♟",
    chess_king = "♚",
    chess_queen = "♛",
    chess_rook = "♜",
    chess_bishop = "♝",
    chess_knight = "♞",
    pawn = "♟",
    king = "♚",
    queen = "♛",
    rook = "♜",
    bishop = "♝",
    knight = "♞",
    bullet = "•",
    bullet_empty = "◦",
    square_bullet = "▪",
    square_bullet_empty = "▫",
    heavy_hyphen = "▬",
    emdash = "─",
    triangle_right = "▶",
    triangle_left_empty = "▷",
    triangle_left = "◀",
    triangle_right_empty = "◁",
    triangle_up = "▲",
    triangle_up_empty = "△",
    triangle_down = "▼",
    triangle_down_empty = "▽",
    triangle_down_left = "◣",
    triangle_down_right = "◢",
    triangle_up_left = "◤",
    triangle_up_right = "◥",
    diamond = "◆",
    diamond_empty = "◇",
    diamond_filled = "◈",
    lozenge = "◊",
    four_diamonds = "❖",
    circle = "●",
    circle_empty = "○",
    circle_no_diacritic = "◌",
    circle_empty_large = "◯",
    circle_filled = "◉",
    circle_double = "◎",
    circle_left_half = "◐",
    circle_right_half = "◑",
    square = "■",
    square_empty = "□",
    square_filled = "▣",
    square_lines_horizontal = "▤",
    square_lines_vertical = "▥",
    square_lines_double = "▦",
    square_hatch_double = "▩",
    square_hatch_left = "▧",
    square_hatch_right = "▨",
    square_circle_hole = "◘",
    square_circle_outline = "◙",
    no = "№",
    ["#"] = "№",
    numero = "№",
    gerard = "( ̊͜┕̊ )"
}

luect.through_tags = {
    ["~~"] = "̶",
    ["__"] = "̲",
    -- ["~"] = "-",
    -- ["_"] = "_",
}

function luect.string_to_tokens(message)
    return {{type = "string", content = message}}
end

function luect.tokenize_emoji(tokens)
    local newTokens = {}
    for _, token in ipairs(tokens) do
        if token.type ~= "string" then
            table.insert(newTokens, token)
        else
            for section, _ in string.gmatch(token.content..":", "(.-):") do
                -- If section content is a valid emoji
                if luect.special_character_tags[section] then
                    table.insert(newTokens, {type = "emoji", content = luect.special_character_tags[section]})
                else
                    local len = #newTokens
                    -- Check if an unnecessary split occured. e.g "Completely innocent colon: Wow!"
                    if newTokens[len] and newTokens[len].type == "string" then
                        -- Add current section to past section
                        newTokens[len].content = newTokens[len].content.. ":" .. section
                    else
                        -- Add new section
                        table.insert(newTokens, {type = "string", content = section})
                    end
                end
            end
        end
    end
    return newTokens
end

function luect.tokenize_colors(tokens, settings)
    settings = settings or {}
    settings.allow_hex = settings.allow_hex == nil and true or settings.allow_hex
    settings.custom_colors = settings.custom_colors or {}

    local newTokens = {}
    local errors = {}
    for _, token in ipairs(tokens) do
        if token.type ~= "string" then
            table.insert(newTokens, token)
        else
            -- Read in chunks of text until a backslash is found
            for section, _ in string.gmatch(token.content.."\\", "(.-)\\") do
                local tags = {}
                 -- Skip sections that are either empty or contain a space
                if section ~= "" and not section:find("%s") then
                    for color, _ in string.gmatch(section.."-", "(%S-)%-") do

                        -- If gradient limit is set and number of tags exceed the limit, stop
                        -- Will still work with too many, it will just ignore the rest
                        if settings.gradient_limit and #tags >= settings.gradient_limit then
                            break
                        end

                        local colorVal = ""
                        -- If tag contains valid color
                        if isHex(color) then
                            if settings.allow_hex then
                                colorVal = color
                            else
                                table.insert(errors, "Hex codes are not allowed in this environment.")
                                break
                            end
                        else
                            if luect.color_tags[color] then
                                colorVal = luect.color_tags[color]
                            elseif settings.custom_colors[color] then
                                colorVal = settings.custom_colors[color]
                            else
                                -- If tag contains invalid color, break and it will be treated as a string
                                tags = {}
                                table.insert(errors, "Invalid color tag: \""..color.."\"")
                                break
                            end
                        end
                        table.insert(tags, colorVal)
                    end
                end
                if #tags > 0 then
                    table.insert(newTokens, {type = "color", content = tags})
                else
                    local len = #newTokens
                    -- Check if an unnecessary split occured. e.g "I'm not like forward slashes, I am different\quirky"
                    if newTokens[len] and newTokens[len].type == "string" then
                        -- Add current section to past section with backslash restored
                        newTokens[len].content = newTokens[len].content.. "\\" .. section
                    else
                        -- Add new section
                        table.insert(newTokens, {type = "string", content = section})
                    end
                end
            end
        end
    end
    return newTokens, table.concat(errors, "\n")
end

function luect.tokenize_throughtags(tokens, original_message)
    for tag, ins in pairs(luect.through_tags) do
        -- Only checks for tags if tag trigger is present in original string
        if original_message and not original_message:find(tag) then goto next_tag end
        local newTokens = {}
        for _, token in ipairs(tokens) do
            if token.type ~= "string" then
                table.insert(newTokens, token)
            else
                -- Searches for chunks of TEXT TAG, TEXT TAG ect
                -- Temporarily adds a trailing tag to get all text
                for section, _ in string.gmatch(token.content..tag, "(.-)("..tag..")") do
                    table.insert(newTokens, {type = "string", content = section})
                    table.insert(newTokens, {type = "through", content = tag})
                end
                -- remove trailing tag
                table.remove(newTokens)
            end
        end
        tokens = newTokens
        ::next_tag::
    end
    return tokens
end

function luect.split_tokens(tokens)
    local newTokens = {}
    local inGradient
    local inThrough = false
    local through = {}
    for _, token in ipairs(tokens) do
        if token.type == "string" then
            if inGradient or inThrough then
                for char, _ in token.content:gmatch("(.)") do
                    if inGradient then
                        inGradient.length = inGradient.length + 1
                    end
                    table.insert(newTokens, {type = "slice", content = char})
                end
            else
                table.insert(newTokens, token)
            end
        elseif token.type == "color" then
            table.insert(newTokens, token)
            if inGradient then
                newTokens[inGradient.index].length = inGradient.length
                inGradient = nil
            end
            if #token.content >= 2 then
                inGradient = {index = #newTokens, length = 0}
            end
        elseif token.type == "through" then
            table.insert(newTokens, token)
            through[token.content] = not through[token.content]
            inThrough = false
            for _, enabled in pairs(through) do
                if enabled then
                    inThrough = true
                    break
                end
            end
        elseif token.type == "emoji" then
            table.insert(newTokens, token)
            if inGradient then
                inGradient.length = inGradient.length + 1
            end
        end
    end
    if inGradient then
        newTokens[inGradient.index].length = inGradient.length
    end
    return newTokens
end

function luect.render_tokens(tokens, settings)
    settings = settings or {}
    local skip_last_through = settings.skip_last_through == nil and true or settings.skip_last_through
    local rendered_string = ""
    local inGradient = nil
    local activeThroughTags = {}
    for index, token in ipairs(tokens) do
        if token.type == "slice" or token.type == "emoji" then
            local grad = ""
            if inGradient and inGradient.colors then
                inGradient.index = inGradient.index + 1
                grad = colESC(luect.lerp_colors(inGradient.colors, inGradient.index / inGradient.length))
            end
            local through = ""
            if skip_last_through and tokens[index+1] and tokens[index+1].type == "slice" then
                for tag, enabled in pairs(activeThroughTags) do
                    if enabled then
                        through = through..luect.through_tags[tag]
                    end
                end
            end
            rendered_string = rendered_string..grad..token.content..through
        elseif token.type == "string" then
            rendered_string = rendered_string..token.content
        elseif token.type == "color" then
            if #token.content >= 2 then
                inGradient = {colors = token.content, index = 0, length = token.length}
            elseif #token.content == 1 then
                inGradient = nil
                rendered_string = rendered_string..colESC(token.content[1])
            end
        elseif token.type == "through" then
            activeThroughTags[token.content] = not activeThroughTags[token.content]
        end
    end
    return rendered_string
end

local function tokenDebug(tokens)
    local rendered_string = ""
    for _, token in ipairs(tokens) do
        local str = ""
        if type(token.content) == "string" then
            str = token.content
        elseif type(token.content) == "table" then
            local tbl = {}
            for _, val in ipairs(token.content) do
                table.insert(tbl, val)
            end
            str = table.concat(tbl, ", ")
        end
        rendered_string = rendered_string.."(["..token.type.."]"..str..")"
    end
    return rendered_string
end

function luect.handle_markup(STRING, settings)
    settings = settings or {}

    -- Initialize defaults if nil
    settings = {
        emoji = settings.emoji == nil and true or settings.emoji,
        color = settings.color == nil and true or settings.color,
        through = settings.through == nil and true or settings.through,
        allow_hex = settings.allow_hex == nil and settings.allow_hex or true,
        gradient_limit = settings.gradient_limit,
        custom_colors = settings.custom_colors or {}
    }
    local errors = ""

    -- Support for tables where each new string creates a new line
    if type(STRING) == "table" then
        STRING = table.concat(STRING, "\n")
    end

    -- Initialize
    local tokens = luect.string_to_tokens(STRING)

    -- Only run if a potential special character ("emoji") tag is present
    if STRING:find(":") and settings.emoji then
        tokens = luect.tokenize_emoji(tokens)
    end

    -- Only run if a potential color tag is present
    if STRING:find("\\") and settings.color then
        tokens, errors = luect.tokenize_colors(tokens, settings)
    end

    -- Pass STRING because it has to do the testing internally
    if settings.through then
        tokens = luect.tokenize_throughtags(tokens, STRING)
    end

    -- Split tokens for through/gradient insertions
    if settings.through or settings.color then
        tokens = luect.split_tokens(tokens)
    end

    return luect.render_tokens(tokens), errors
end

local function getKeys(tbl)
    local keys = {}
    for key, _ in pairs(tbl) do
        table.insert(keys, key)
    end
    return keys
end

function luect.stress_test(stress)
    local words = {
        "lorem", "ipsum", "dolor", "sit", "amet", "foo", "bar","the", "is", "it", "if", "who","what",
        "when","where","how","why","bine","urf","seark","udel","gum","te","durfen","akut","niltra",
        "mon","dobren","kir-eklira","tse","kirk","marunte","pok","tsu","avira","latsir","tok","tsau",
        "maecenas","sollicitudin","vulputate","neque","in","laoreet","purus","feugiat","pulvinar",
        "donec","volutpat","finibus","urna","eget","efficitur","dolor","egestas","vestibulum",
        "sed","ligula","tristique","efficitur","metus","dapibus","faucibus","eros","morbi","ac",
        "vestibulum","magna","vitae","sollicitudin","phasellus","turpis","nulla","porta","vel","sed",
        "tincidunt","aliquet","a","tortor","maecenas","faucibus","urna","in","blandit", "et",
        "fermentum","integer","condimentum","enim","quis","purus","tincidunt","varius","proin","felis",
        "mi","pharetra","in","tempor","sed","porttitor","tincidunt","mauris","nulla","accumsan",
        "odio","ut","congue","tellus","sed","metus","ultricies","mattis","gravida","lobortis",
        "dui","vulputate","nunc","venenatis","enim","id","nibh","mattis","ultrices","nulla",
        "tempor","fusce","ullamcorper","risus","eu","nulla","mollis","non","imperdiet","urna"
    }
    local emojis = getKeys(luect.special_character_tags)
    local colors = getKeys(luect.color_tags)
    local through = getKeys(luect.through_tags)
    local len = 100 + (stress)
    stress = math.max(1, stress)
    local str = ""
    local newSentence = true
    for i = 0, len do
        local word = words[math.random(1, #words)]
        local pChance = math.random(0, 50)
        local pun = pChance > 45 and ". " or pChance > 35 and ", " or " "
        if newSentence then
            word = string.sub(word, 1, 1):upper()..string.sub(word, 2)
        end
        if pun == ". " then newSentence = true else newSentence = false end
        local falsePositive = math.random(0, 10) > 5
        if falsePositive then
            local additive = ({"\\", ":"})[math.random(1, 2)]
            word = word..additive
        end
        local stressInsert = ""
        local stressStart = math.random(0, 1) == 1
        if math.random(math.floor(100 / stress)) == 1 then
            local type = ({"emoji", "color", "through"})[math.random(1, 3)]
            if type == "emoji" then
                stressInsert = ":"..emojis[math.random(1, #emojis)]..":"
            elseif type == "color" then
                local isGradient = math.random(0, 10) > 5
                if isGradient then
                    stressInsert = colors[math.random(1, #colors)].."-"..colors[math.random(1, #colors)]
                else
                    stressInsert = colors[math.random(1, #colors)]
                end
                stressInsert = "\\"..stressInsert.."\\"
            elseif type == "through" then
                stressInsert = through[math.random(1, #through)]
            end
        end
        if stressStart then
            str = str..stressInsert..word..pun
        else
            str = str..word..stressInsert..pun
        end
    end
    return luect.handle_markup(str)
end

core.register_chatcommand("luect_test", {
    description = "Generate and render a Luect markup test string.",
    params = "<stress level>",
    privs = {server = true},
    func = function(name, param)
        local stressLevel = 50
        if param ~= "" then
            local n = string.match(param, "%d+")
            luect.stressLevel = tonumber(n)
        end
        return true, luect.stress_test(stressLevel)
    end
})
