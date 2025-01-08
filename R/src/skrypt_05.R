#Paczki
library(tidyverse)
pingwiny <- palmerpenguins::penguins
#test potokowania
#1. Stworzyź wekroe 2 policzyć sume skumulowanną 3. Policzyć średnią
#Nadpisywanie kolejnymi warrościami
dane_nadpisane <- c(6,7,8,9)
dane_nadpisane <- cumsum(dane_nadpisane)
dane_nadpisane <- mean(dane_nadpisane)

#Zapis z zagnieżdzoną funkcją
dane_funkcja <- mean(cumsum(c(6, 7, 8, 9)))

#Zapis z użyciem potokowania ("pipe")
dane_potok <- c(6,7,8,9) |>
  #Komentarz 1
  cumsum() |>
  #Komentarz 2
  mean()

#tidtr ####
data <- iris

#Zmiana formatu long na wide
l_2_w <- data |>
  tidyr::pivot_wider(names_from = Species, values_from = Sepal.Length:Petal.Width)

#pingwiny_wide <- pingwiny |>
 # tidyr::drop_na() |>
 #Zmiana formatu na szerszy
  #tidyr::pivot_wider(names_from = sex, values_from = -sex)

#Nadanie id pingwinom
pingwiny <- pingwiny |>
  mutate(id = 1:length(year))

#Zmiana formatu wide na long
pingwiny_longer <- pingwiny |>
  tidyr::pivot_longer(bill_length_mm:body_mass_g,
                      names_to = "zmienna", values_to = "wartosci", )

ggplot2::ggplot(pingwiny_longer, aes(year, wartosci,colour = species))+
  geom_point()+
  facet_wrap(vars(zmienna))

#Do szerokiego
pingwiny_wider <- pingwiny_longer |>
  #Zmiana dormatu ramki
  tidyr::pivot_wider(names_from = zmienna, values_from = wartosci)


#Joins (operacje na wielu ramkach) ####
#Podział na płeć
pingwiny_m <- pingwiny |>
  #wybór samców
  dplyr:: filter(sex == "male")

#Wybór samic
pingwiny_s <- pingwiny |>
  dplyr::filter(!sex == "male")

#łączenie wierszy = bind rows
pingwiny_m_s <-  dplyr:: bind_rows(pingwiny_m, pingwiny_s)

#podział kolumnami
pingwiny1 <- pingwiny |>
  select(species: body_mass_g)

pingwiny2 <- pingwiny |>
  select(-c(species:body_mass_g))

#łączenie kolumnami - bind cols
pingwiny_1_2 <- dplyr::bind_cols(pingwiny1, pingwiny2)
