#Załadowanie paczek:
library(tidyverse)

#Dane z internetu
dane_www <- readr::read_csv(file = "https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv")

#Wczytanie z dysku z pełną ścierzką - bezwzględna
dane_dysk_full_path <- readr::read_csv(file = "D:/8_GITHUB/Projekt1/Repozytorium_ProjektSemestralny/R/data/annual-enterprise-survey-2023-financial-year-provisional (1).csv")

#Wczytanie z dysku z krótką ścierzka - względna
dane_dysk_short_path <- readr::read_csv(file = "R/data/annual-enterprise-survey-2023-financial-year-provisional (1).csv")

#Zamiana kolumny tekstowej na liczbową:
dane_dysk_short_path$Value <- as.numeric(dane_dysk_short_path$Value)

#Pasowanie tekstu na numery
dane <- readr::read_csv(file = "R/data/annual-enterprise-survey-2023-financial-year-provisional (1).csv")
dane$Value <- readr::parse_number(dane$Value)

dane[748, "Value"]
