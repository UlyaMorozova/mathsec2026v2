function create_grille(n::Int)
    # создаем пустую решетку n x n с отверстиями (true) и не отверстиями (false)
    grille = falses(n, n)
    holes = div(n*n, 4)  # половина отверстий (четверть площади, 4 прохода)
    count = 0
    for i in 1:n
        for j in 1:n
            if (i + j) % 2 == 1 && count < holes
                grille[i,j] = true
                count += 1
            end
        end
    end
    return grille
end

function rotate_grille(grille)
    # Поворот решетки на 90 градусов по часовой стрелке
    return reverse(transpose(grille), dims=1)
end

function encrypt_grille(text::String, n::Int)
    grille = create_grille(n)
    grid = fill(' ', n, n)  # пустая матрица для шифротекста
    padded_text = lpad(text, n*n)  # дополнение текста пробелами, если он короче n^2
    idx = 1
    for _ in 1:4  # четыре поворота
        for i in 1:n
            for j in 1:n
                if grille[i,j]
                    grid[i,j] = padded_text[idx]
                    idx += 1
                end
            end
        end
        grille = rotate_grille(grille)
    end
    return grid
end

function decrypt_grille(grid, n::Int)
    grille = create_grille(n)
    decrypted = ""
    for _ in 1:4
        for i in 1:n
            for j in 1:n
                if grille[i,j]
                    decrypted *= string(grid[i,j])
                end
            end
        end
        grille = rotate_grille(grille)
    end
    return strip(decrypted)
end

n = 6
text = "WE ARE RUNNING ALL DAY AND NIGHT"
encrypted = encrypt_grille(text, n)
for i in 1:n
    println(String(encrypted[i, :]))
end

decrypted = decrypt_grille(encrypted, n)
println("Дешифровка: ", decrypted)