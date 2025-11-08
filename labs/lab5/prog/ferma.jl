function euclidean(a::T, b::T) where T<:Integer 
    a=abs(a)
    b=abs(b)

    while b != 0
        a,b = b, a%b
    end
    return a
end

function binary_euc(a::T, b::T) where T<:Integer
    a=abs(a)
    b=abs(b)

    if a == 0
        return b
    end
    if b == 0
        return a
    end

    s = 0
    while ((a|b)&1) == 0
        a>>=1
        b>>=1
        s += 1
    end

    while (a&1) == 0
        a>>=1
    end

    while b != 0
        while (b&1) == 0
            b>>=1
        end
        
        if a>b
            a,b = b,a
        end
        b -= a
    end

        return a<<s
end

function ext_euc(a::T, b::T) where T<:Integer
    if b == 0
        return a, one(T), zero(T)
    end
    
    gcd_val, x1, y1 = extended_gcd(b, a % b)
    x = y1
    y = x1 - (a ÷ b) * y1
    
    return gcd_val, x, y
end

function binary_ext(a::T, b::T) where T <: Integer
    a = abs(a)
    b = abs(b)
    
    g = 1
    while iseven(a) && iseven(b)
        a >>= 1
        b >>= 1
        g <<= 1
    end
    
    u, v = a, b
    A, B, C, D = one(T), zero(T), zero(T), one(T)
    
    while u != 0
        while iseven(u)
            u >>= 1
            if iseven(A) && iseven(B)
                A >>= 1
                B >>= 1
            else
                A = (A + b) >> 1
                B = (B - a) >> 1
            end
        end
        
        while iseven(v)
            v >>= 1
            if iseven(C) && iseven(D)
                C >>= 1
                D >>= 1
            else
                C = (C + b) >> 1
                D = (D - a) >> 1
            end
        end
        
        if u >= v
            u -= v
            A -= C
            B -= D
        else
            v -= u
            C -= A
            D -= B
        end
    end
    
    val = v * g
    return val, C, D  
end

function test_gcd_algorithms()
    test_cases = [
        (48, 18),
        (1071, 462),
        (17, 13),
        (100, 25),
        (0, 5),
        (7, 0),
        (123456789, 987654321)
    ]
    
    println("Тестирование алгоритмов НОД:")
    println("="^50)
    
    for (a, b) in test_cases
        gcd1 = euclidean(a, b)
        gcd2 = binary_euc(a, b)
        gcd3, x3, y3 = ext_euc(a, b)
        gcd4, x4, y4 = binary_ext(a, b)
        
        println("НОД($a, $b) = $gcd1")
        println("Классический: $gcd1")
        println("Бинарный: $gcd2")
        println("Расширенный: $gcd3 (коэффициенты: $x3, $y3)")
        println("Бинарный расширенный: $gcd4 (коэффициенты: $x4, $y4)")
        
        # Проверка тождества Безу
        bezout_check3 = a * x3 + b * y3 == gcd3
        bezout_check4 = a * x4 + b * y4 == gcd4
        
        println("Тождество Безу (расширенный): $bezout_check3")
        println("Тождество Безу (бинарный расширенный): $bezout_check4")
        println("-"^30)
    end
end