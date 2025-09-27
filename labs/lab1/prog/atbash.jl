function atbash_cipher(text::String)
    result = IOBuffer()
    for c in text
        if 'A' <= c <= 'Z'
            write(result, Char('Z' - (c - 'A')))
        elseif 'a' <= c <= 'z'
            write(result, Char('z' - (c - 'a')))
        else
            write(result, c)
        end
    end
    return String(take!(result))
end
