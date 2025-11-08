function jacobi_symbol(a, n)

    if n % 2 == 0 || n <= 0
        throw(ArgumentError("n должно быть нечетным положительным целым"))
    end
    
    # Приводим a по модулю n
    a = a % n
    result = 1
    
    while a != 0
        # Убираем множители 2
        while a % 2 == 0
            a ÷= 2
            # (2/n) = (-1)^((n^2-1)/8)
            if n % 8 == 3 || n % 8 == 5
                result = -result
            end
        end
        
        # Меняем местами по квадратичному закону взаимности
        a, n = n, a
        
        # (a/n) = (-1)^((a-1)(n-1)/4) * (n/a)
        if a % 4 == 3 && n % 4 == 3
            result = -result
        end
        
        a = a % n
    end
    
    return n == 1 ? result : 0
end

function solovay_strassen_test(n, k=10)

    # Обработка особых случаев
    if n <= 1
        return false
    elseif n == 2
        return true
    elseif n % 2 == 0
        return false
    end
    
    # Проверяем k случайных оснований
    for _ in 1:k
        # Выбираем случайное a в диапазоне [2, n-1]
        a = rand(2:(n-1))
        
        # Вычисляем символ Якоби
        jacobi = jacobi_symbol(a, n)
        if jacobi == 0
            return false  # gcd(a, n) > 1, число составное
        end
        
        # Вычисляем a^((n-1)/2) mod n
        exponent = (n - 1) ÷ 2
        mod_result = powermod(a, exponent, n)
        
        # Приводим символ Якоби к модулю n
        jacobi_mod = jacobi >= 0 ? jacobi : jacobi + n
        
        # Проверяем условие Эйлера
        if mod_result != jacobi_mod
            return false
        end
    end
    
    return true
end

function test_soloveya_examples()
    test_numbers = [
        7, 11, 13, 17, 19,  # Простые числа
        9, 10, 12, 14, 15,  # Составные числа
        35, 548, 827, 1983
    ]
    
    println("Тест Соловея-Штрассена для различных чисел:")
    println("="^50)
    
    for n in test_numbers
        result = solovay_strassen_test_test(n, 5)
        status = result ? "вероятно простое" : "составное"
        println("$n: $status")
    end
end