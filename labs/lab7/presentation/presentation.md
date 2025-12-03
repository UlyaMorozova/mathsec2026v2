---
## Front matter
lang: ru-RU
title: Лабораторная работа №7
author:
  - Морозова Ульяна
institute:
  - Российский университет дружбы народов, Москва, Россия


## i18n babel
babel-lang: russian
babel-otherlangs: english

## Formatting pdf
toc: false
toc-title: Содержание
slide_level: 2
aspectratio: 169
section-titles: true
theme: metropolis
header-includes:
 - \metroset{progressbar=frametitle,sectionpage=progressbar,numbering=fraction}
---

## **Цель работы**

Целью работы является изучение алгоритм разложение чисел на множителей и реализация его на языке Julia.

## Алгоритм p-метода Полларда для задачи дискретного логарифмирования

Алгоритм $\rho$-Полларда (Pollard's rho) — это вероятностный алгоритм для вычисления дискретного логарифма. Он особенно эффективен, когда порядок циклической группы является составным числом с небольшими простыми делителями, но работает и в общем случае быстрее, чем алгоритм перебора (Baby-step Giant-step), потребляя при этом значительно меньше памяти.


## Код 

```julia
function extended_gcd(a::BigInt, b::BigInt)
    if a == 0
        return b, 0, 1
    else
        g, y, x = extended_gcd(b % a, a)
        return g, x - (b ÷ a) * y, y
    end
end

function pollard_rho_dlp(alpha::Union{Int, BigInt}, beta::Union{Int, BigInt}, p::Union{Int, BigInt})
    alpha, beta, p = BigInt(alpha), BigInt(beta), BigInt(p)
    n = p - 1  
    function step(x, a, b)
        mode = x % 3
        if mode == 0
            # S0: x -> x^2
            x_new = powermod(x, 2, p)
            a_new = (a * 2) % n
            b_new = (b * 2) % n
        elseif mode == 1
            # S1: x -> x * alpha
            x_new = (x * alpha) % p
            a_new = (a + 1) % n
            b_new = b
        else
            # S2: x -> x * beta
            x_new = (x * beta) % p
            a_new = a
            b_new = (b + 1) % n
        end
        return x_new, a_new, b_new
    end
```

## Результат его работы

```bash
Задача: 2^x = 22 (mod 29)
Дискретный логарифм x: 26
Проверка: 22 == 22
```

## Выводы

Мы изучили работу алгоритма, а также реализовали его на языке Julia.

::: {#refs}
:::