#load packages
library(tidyverse)

data <- iris

#średnia długość płatka
srednia_platek <- mean(data$Petal.Length)
mediana_platek <- median(data[ ,1])
odchylenie_platk <- sd(data$Petal.Length)

#średnie dla gatunków
sredni_platek_setosa <- mean(data[1:50,4])
sredni_platek_versic <- mean(data[51:100,4])
sredni_platek_virginica <- mean(data[101:150,4])

#średnia dla gatunku po nazwie
sredni_platek_setosa_nazwa <- mean(data[data$Species == "setosa",4])

#Podsumowanie
podsumowanie <- summary(data)
podsumowanie
print(podsumowanie)

podsumowanie_2 <- summary(data[ ,1:2]) #data[,1:2] == c(1,2)
podsumowanie_2

#suma dugości
data$Suma.długosci <- data$Sepal.Length + data$Petal.Length

#frakcja
data$Frakcja <- (data$Sepal.Length+data$Petal.Length)/data$Sepal.Width

#Srednia jako kolumna
data$srednia <- mean(c(data$Sepal.Length,data$Petal.Length))

#Ramka dla danych setosa
data_setosa <- data[data$Species== c("setosa","versicolor"), ]

#Ramka danych tylko dla oryginalnych kolumn
data_orgin <- dplyr::select(data,Sepal.Length:Species)

#Wybór zmiennych wg nazwy z zapisem od:do
data_org__tylko_sep <- dplyr::select(data,Sepal.Length:Sepal.Width)

#Wybór zmiennych wg nazwy z zapisem sklejanym
data_org_tylko_sep2 <- dplyr::select(data,(c(Sepal.Length,Sepal.Width)))

#Wybór zmiennych wg nazwy z zapisem wg początku
data_org_tylko_sep3 <- dplyr::select(data, starts_with("Sepal"))

#Wybór zmiennych wg nazwy z zapisem wg końca
data_org_tylko_sep4 <- dplyr::select(data, ends_with("Lenght"))


#Wybór zmiennych wg nazwy z zapisem dowolnyh znaków wspólnych
data_org_tylko_sep5 <- dplyr::select(data, contains("al"))

#Wybór zmiennych wg nazwy z zapisem wg początku - zanegowane
data_org_tylko_sep6 <- dplyr::select(data, !starts_with("Sepal"))


### Wybór wierszy ####
#wybór wierszy gatunek setosa
data_wiersze_1 <- dplyr::filter(data, Species == "setosa")

#wybór wierszy bez gatunek setosa
data_wiersze_2 <- dplyr::filter(data, !Species == "setosa")

#Wybór wierszy gdzie długość płatka petal lengt większa od 5
data_wiersze3 <- dplyr::filter(data, Petal.Lenght)

