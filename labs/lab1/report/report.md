---
## Front matter
title: "Отчет по лабораторной работе №1"
subtitle: "*дисциплина: Математические основы защиты информации и информационной безопасности*"
author: "Морозова Ульяна Константиновна"

## Generic otions
lang: ru-RU
toc-title: "Содержание"

## Bibliography
bibliography: bib/cite.bib
csl: pandoc/csl/gost-r-7-0-5-2008-numeric.csl

## Pdf output format
toc: true # Table of contents
toc-depth: 2
lof: false # List of figures
lot: false # List of tables
fontsize: 12pt
linestretch: 1.5
papersize: a4
documentclass: scrreprt
## I18n polyglossia
polyglossia-lang:
  name: russian
  options:
	- spelling=modern
	- babelshorthands=true
polyglossia-otherlangs:
  name: english
## I18n babel
babel-lang: russian
babel-otherlangs: english
## Fonts
mainfont: IBM Plex Serif
romanfont: IBM Plex Serif
sansfont: IBM Plex Sans
monofont: IBM Plex Mono
mathfont: STIX Two Math
mainfontoptions: Ligatures=Common,Ligatures=TeX,Scale=0.94
romanfontoptions: Ligatures=Common,Ligatures=TeX,Scale=0.94
sansfontoptions: Ligatures=Common,Ligatures=TeX,Scale=MatchLowercase,Scale=0.94
monofontoptions: Scale=MatchLowercase,Scale=0.94,FakeStretch=0.9
mathfontoptions:
## Biblatex
biblatex: true
biblio-style: "gost-numeric"
biblatexoptions:
  - parentracker=true
  - backend=biber
  - hyperref=auto
  - language=auto
  - autolang=other*
  - citestyle=gost-numeric
## Pandoc-crossref LaTeX customization
figureTitle: "Рис."
tableTitle: "Таблица"
listingTitle: "Листинг"
lofTitle: "Список иллюстраций"
lotTitle: "Список таблиц"
lolTitle: "Листинги"
## Misc options
indent: true
header-includes:
  - \usepackage{indentfirst}
  - \usepackage{float} # keep figures where there are in the text
  - \floatplacement{figure}{H} # keep figures where there are in the text
---

# **Цель работы**

Целью работы является изучение алгоритмов шифрования Цезаря и Атбаша и реализация их на языке Julia.


# Выполнение лабораторной работы

## Шифр Цезаря

Суть шифра Цезаря заключается в том, что происходит смещение всех букв по алфавиту в сообщении на некоторый коэффициент k. Декодирование происходим путем смещения в обратную сторону.

Далее приведена реализация шифра на языке Julia для русского и английского алфавита.

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

На вход функция принимает слово, которое нужно (де)шифровать, шаг шифра, а также булевый параметр, отвечающий за (де)шифрование.

Результат работы шифра:

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

Его реализация:

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

Выполнение работы кода:

```bash
julia> atbash_cipher("TOMORROW")
"GLNLIILD"
```


# Выводы

Мы изучили работу алгоритмов шифрования Цезаря и Атбаша, а также реализовали их на языке Julia.


::: {#refs}
:::