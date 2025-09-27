function caeser_cipher(text::AbstractString, k::int, encrypt::Bool=true)
    rus_alphabet = collect("АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЬЭЮЯ")
    eng_alphabet = collect("ABCDEFGHIJKLMNOPQRSTUWXYZ")

    result=IOBuffer()

    for c in uppercase(text)
        if c in rus_alphabet
            alphabet = rus_alphabet
        elseif c in eng_alphabet
            alphabet = eng_alphabet
        else
            print(result, c)
            print("Unknown language")
            continue
        end
        
        n = length(alphabet)
        index_c = findfirst(==(c), alphabet)
        if encrypt
            new_index = mod(index_c - 1 + k, n) + 1
        else
            new_index = mod(index_c - 1 - k, n) + 1
        end
        print(result, alphabet[new_index])
    end
    return String(take!(result))
end