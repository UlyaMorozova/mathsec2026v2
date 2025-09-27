function vigenere_encrypt(text, key)
        alphabet = 'a':'z'
        output = ""
        key_index = 1

        for i in text
                if isletter(i)
                        offset = findfirst(isequal(key[key_index]), alphabet) - 1
                        index = findfirst(isequal(i), alphabet) + offset
                        index > 26 && (index -= 26)
                        output *= alphabet[index]
                        key_index += 1
                        key_index > length(key) && (key_index = 1)
                else
                        output *= i
                end
        end

        return output
end

text = "i lose my breathe"
key = "waltz"
println(vigenere_encrypt(text, key))