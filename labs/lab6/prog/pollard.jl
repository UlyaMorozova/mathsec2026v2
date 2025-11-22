using Random

function pollard_rho(n::Integer, c::Integer=1, f::Function=x -> x^2+1)
    a = c
    b = c

    while true
        a = f(a)%n
        b = f(f(b)%n) % n 

        d = gcd(abs(a-b),n)

        if 1<d<n
            return d
        elseif d==n 
            return 0
        end
    end
end

function test_pollard()
    println("Тестирование p-метода Полларда")
    println('='^40)

    test_cases = [
        (8051, 1, "8051"),
        (10403, 1, "10403"),
        (15251, 1, "15251"),
        (123456789, 1, "123456789"),
        (987654321, 1, "987654321"),
        (15, 1, "15"),
        (21, 1, "21"),
        (35, 1, "35")
    ]
    
    for (n, c, desc) in test_cases
        println("\nТест: $desc")
        println("n = $n, c = $c")
        
        result = pollard_rho(n, c)
        
        if result == 0
            println("Результат: Делитель не найден")
        else
            println("Результат: Найден делитель p = $result")
            println("Проверка: $n = $result × $(n ÷ result)")
            println("Верность: $(result * (n ÷ result) == n)")
        end
        println('-'^40)
    end
end
