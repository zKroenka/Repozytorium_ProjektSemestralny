#SKRYPT 27.11

#wczytanie paczek
library(tidyverse)
library(readxl)

#Wczytanie danych
ramka <- readxl::read_excel("R/data/moje_dane.xlsx", sheet = "Arkusz1")
ramka <- dplyr::rename(ramka,KROKI="Kroki[kroki/h]",
                       WODA="Woda[ml/h]",
                       TETNO="Tetno",
                       H = "Godzina")

head(ramka)

#ZMIANA NAZW Z WIELKIEJ LIYEERY NA MAŁĄ wszystkie
ramka3 <- dplyr::rename_with(ramka,
                             .cols = everything(),
                             \(i)tolower(i))
head(ramka3)

#ZMIANA NAZW Z małej LIYEERY NA wielką - wybor
ramka4 <- dplyr::rename_with(ramka3,
                             .cols = dplyr::starts_with("data"),
                             \(i)toupper(i))
head(ramka4)

#ZMIANA NAZW Z małej LIYEERY NA wielką -wybor
ramka5 <- dplyr::rename_with(ramka4,
                             .cols = dplyr::contains("h"),
                             \(i)toupper(i))
head(ramka5)

#WYBRANIE DOBRYCH KOLUMN XD
ramka6<-subset(ramka5,select=c(DATA,H, kroki, woda, tetno))
head(ramka6)

#OPERACJE NA KOLUMNACH
ramka$col7 <- ramka[,8]/ramka[,9]

#operacje na kolumnach mutate
ramka7 <- dplyr::mutate(ramka6,
                        wynik_dzielenia = woda/tetno,
                        wynik_dodatawnia = kroki+1)

head(ramka7)


ramka8 <- dplyr::mutate(ramka,
                        wynik_odejmowania = TETNO -10,
                        .keep="none")



ramka9 <- dplyr::relocate(ramka7, tetno,.before=3)
head(ramka9)
#ROBOCZE rzykład
ramka2 <- readxl::read_excel("R/data/moje_dane.xlsx",sheet="Arkusz2")
head(ramka2)
ramka2 <- dplyr::rename(ramka2, woda= ...7, moja_zeminna=Godzina)
head(ramka2)
