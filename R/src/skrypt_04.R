#Dzień 4.12.2024

#Libraries
library(tidyverse)

# Wczytanie danych
data(iris)

dane <- iris

# Zmiana nazw kolumn na małe litery
dane <- dplyr::rename_with(dane, \(i) tolower(i))

# Dodanie dodatkowej kolumny
dane <- dplyr::mutate(dane, iloraz = petal.length / petal.width)

#grupowanie danych
dane_g <- dplyr::group_by(dane, species)

#Wydrukuj do konsoli
dane_g

#Podsumowania
dane_s <-  dplyr::summarise(dane_g, srednia = mean(sepal.length),
                                    srednia2 = mean(sepal.width))

#Praca na kilku kolumnach na raz
#Log z danych w kolumnie
dane_l <- dplyr::mutate(dane, sepal.length = log(sepal.length))
#Pierwiastek z 2 kolumn
dane_2 <- dplyr::mutate(dane, petal_length = sqrt(petal.length),
                              sepal.width = sqrt(sepal.width))
#Pierwiastek z 2 kolumn szybciej - accros
dplyr::across()
dane_3 <- dplyr::mutate(dane, dplyr::across(sepal.length:petal.width, \(i) log10(i)))

#across, log 10 przez col które mają w nazwie length

dane_4 <- dplyr::mutate(dane, dplyr::across(dplyr::contains("lenght"), \(i) log10(i)))

#Accros 1 kol po nazwe, dwie po początku nazwy
dane_5 <- dplyr::mutate(dane,
                        dplyr::across(c(sepal.length, dplyr::contains("width")), \(i) log10(i)))


#Across i zwykłe mutate kolumny zaczynające się od petal = log 2 dodaj kolumne z wynikiem dzielenia kolumn petal
dane_6 <- dplyr::mutate(dane,
                        dplyr::across(dplyr::starts_with("petal"), \(i) log2(i)),
                        iloraz = petal.length / petal.width)

#Across w sumarize
dane_7 <- dplyr::summarise(dane, dplyr::across(dplyr::everything(), \(i) mean(i)))

#Across na wartoścniach numerycznych
dane_8 <- dplyr::summarise(dane, dplyr::across(dplyr::where( \(i) is.numeric(i)),
                                               \(i) mean(i) ))
#Across na wartoścniach numerycznych więcej niż 1 funkcja
dane_9 <- dplyr::summarise(dane,
                           dplyr::across(dplyr::where( \(i) is.numeric(i)),
                                          list(srednia = \(i) mean(i), mediana = \(i) median(i) )))

#Potokowanie - piping
#Dodaj nową kolumne, wynik dodawania wszystkich kolumn do siebie
dane_10 <- dplyr::mutate(dane, suma = sepal.length + sepal.width+petal.length + petal.width)

#Zgupuj te same dane po kolumnie species
dane_10 <- dplyr::group_by(dane_10, species)

#[plicz srednia wartosc wszystkich kolumn liczbowych
dane_10 <- dplyr::summarise(dane_10, dplyr::across(dplyr::where(\(i) is.numeric(i)), \(i) mean(i)))

dane_11 <- dane |>
  dplyr::mutate(suma = sepal.length + sepal.width+petal.length + petal.width) |>
  dplyr::group_by(species) |>
  dplyr::summarise(dplyr::across(dplyr::where(\(i) is.numeric(i)), \(i) mean(i)))
