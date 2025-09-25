---
## Front matter
lang: ru-RU
title: Лабораторная работа №1
author:
  - Морозова Ульяна
institute:
  - Российский университет дружбы народов, Москва, Россия

date: 01 января 1970

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

## Цели

Целью работы является изучение алгоритмов шифрования Цезаря и Атбаша и реализация их на языке Julia.

## Шифр Цезаря

Суть шифра Цезаря заключается в том, что происходит смещение всех букв по алфавиту в сообщении на некоторый коэффициент k. Декодирование происходим путем смещения в обратную сторону.

Далее приведена реализация шифра на языке Julia для русского и английского алфавита.

## Код


```julia
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
```

## Результат работы шифра

```bash
julia> caesar_cipher("EVENING", 3, encrypt=true)
"HYHQLQJ"
``` 
```bash
julia> caesar_cipher("HYHQLQJ", 3, encrypt=false)
"EVENING"
```

## Шифр Атбаша

Шифр представляет собой шифр сдвига на всю длину алфавита.

## Код

```julia
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
```

## Выполнение работы кода

```bash
julia> atbash_cipher("TOMORROW")
"GLNLIILD"
```

## Выводы

Мы изучили работу алгоритмов шифрования Цезаря и Атбаша, а также реализовали их на языке Julia.


::: {#refs}
:::