# Powtórka; grupa 1, 22.01.2025

# Załaduj paczki {tidyverse}, {readxl}
library(tidyverse)
library(readxl)
# Stwórz jednowymiarowy wektor o pięciu elementach liczbowych
wektor <- c(1,5,7,3,4)
# Wybierz czwartą i trzecią (w tej kolejności) pozycję w utworzonym wektorze i zapisz jako nowy wektor
wektor2 <- c(wektor[4], wektor[3])
wektor2 <- wektor[c(4,3)]
# Wczytaj dane z iris dataset
data <- iris
# Wybierz drugą kolumnę i wszystkie wiersze
data1 <- data[,2]
# Wybierz czwarty i trzydiesty wiersz oraz wszystkie kolumny - klasyczne indeksowanie
data2 <- data[c(4,30),]
# Wybierz wiersze 4, 8, 22 i kolumny Petal.Length oraz Sepal.Width - klasyczne indeksowanie
data3 <- data[c(4,8,22),c(3,2)]
data3 <- data[c(4,8,22),c("Petal.Length","Sepal.Width")]
# Wybierz kolumnę Species korzystając z operatora $
data4 <- data$Species
 # Uwtórz nową kolumnę "Petal.Iloraz" w ramce danych, tak aby była ilorazem Petal.Length i Petal.Width
data5$Petal.Iloraz <- data$Petal.Length /data$Sepal.Width
# Wczytaj dane z adresu sieciowego, zwróć uwagę na separator
# https://support.staffbase.com/hc/en-us/article_attachments/360009197031/username.csv
dane_siec <- read_csv2(file = "https://support.staffbase.com/hc/en-us/article_attachments/360009197031/username.csv", )
# Wczytaj dane z pliku csv na dysku
dane_dysk <- read_csv(file = "R/data/annual-enterprise-survey-2023-financial-year-provisional (1).csv")
# Wczytaj dane z pliku excel na dysku, wyraźnie wskaż arkusz
dane_excel <- readxl::read_excel(path = "R/data/data_msu.xlsx", sheet = 1)
# {dplyr} i {tidyr}

# Wczytaj dane dotyczące pingwinów
pingwiny <- palmerpenguins::penguins

# Zmień nazwę species na gatunek
dane1 <- rename(pingwiny, gatunek=species)
# Zmień wszystkie nazwy tak aby były pisane wielką literą
dane2 <- rename_with(pingwiny,
                     .cols = everything(),
                     \(i) toupper(i))

# Wybierz kolumny od bill_length_mm do body_mass_g
dane3 <-select(pingwiny, bill_length_mm:body_mass_g)
# Wybierz kolumny kończące się na "mm"
dane4 <- select(pingwiny, ends_with("mm"))
# Wybierz kolumny zawierające "th"
dane5 <- pingwiny |> select(contains("th"))
dane5 <- select(pingwiny, contains("th"))
# Wybierz kolumny niebędące species
dane6 <- select(pingwiny, !species )
dane6 <- select(pingwiny, -species)
# Uwtórz nową kolumnę bill_ratio jako iloraz bill_length_mm do bill_depth_mm
dane7 <-  pingwiny |> mutate(bill_ratio = bill_length_mm/bill_depth_mm)
# Utwórz kolumnę id z numerem obserwacji (tip: 1:n())
pingwiny <- pingwiny |> mutate(ID = 1:n())
# Zlogarytmuj w miejscu kolumnę body_mass_g
dane8 <- pingwiny |> mutate(body_mass_g = log(body_mass_g))
# Oblicz w miejscu pierwiastek ze wszystkich kolumn numerycznych
dane9 <- pingwiny |> mutate(across(where(\(i) is.numeric(i)),
                            \(i) sqrt(i)))

# Zgrupuj ramkę ranych na podstawie zmiennej gatunek i wykonaj operację summarise (średnia)
#dla kolumn bill_length_mm i body_mass_g
dane10 <- pingwiny |> group_by(species) |> summarise(srednia=mean(bill_length_mm, na.rm = TRUE), srednia2=mean(body_mass_g, na.rm = TRUE))

# Wykonaj operację summarise (mediana) dla kolumn bill_length_mm i body_mass_g, wskaż zmienną grupującą jako argument .by
dane11 <- pingwiny |> summarise(mediana1= median(bill_length_mm, na.rm=TRUE) ,
                                mediana2= median(body_mass_g, na.rm=TRUE), .by =species )

# Zmień format ramki na dłuższy, wykorzystaj kolumny bill_length_mm i bill_depth_mm
dane12 <- pingwiny |>  pivot_longer(cols = c(bill_length_mm, bill_depth_mm),
                                    names_to = "bill_type",
                                    values_to = "bill_value")
# Zmień format ramki na szerszy, tak aby każda zmienna była wyrażona dla każdej wyspy
dane13 <- pingwiny |> pivot_wider(id_cols = ID,
                                    names_from = island,
                                    values_from = -c(ID,island))
# Korzystając z danych geochemicznych połącz ze sobą ramki loi oraz bsi na podstawie zmiennej sample.id - dołącz do lewej
dane_loi <- readxl::read_excel(path = "R/data/data_msu.xlsx", sheet = 1)
dane_elemental <- readxl::read_excel(path = "R/data/data_msu.xlsx", sheet = 2)
dane_bsi <- readxl::read_excel(path = "R/data/data_msu.xlsx", sheet = 3)

dane_1 <- left_join(dane_loi,dane_bsi, join_by(sample.id==saple.id))

# Korzystając z danych geochemicznych połącz ze sobą ramki elemental oraz bsi na podstawie zmiennej sample.id - dołącz do prawej
dane_2 <- right_join(dane_elemental, dane_bsi, join_by(sample.id))
# Korzystając z danych geochemicznych połącz ze sobą wszystkie trzy ramki w sposób całkowity
dane_3 <-full_join(dane_loi, dane_bsi, join_by(sample.id)) |>  full_join(x=_,y=dane_elemental, join_by(sample.id))
