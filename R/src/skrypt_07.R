#skrypt 07 - 29.01.25

#Paczki
library(tidyverse)
library(lubridate)
library(ggplot2)

#Dane hydrochemiczn
zab_hydrochemia <- read.csv(file ="R/data/Nowy folder/zab_hydrochemistry-lake.csv") |>
  mutate(date= lubridate::ymd(date))

#wykres: x = czas, y= wartość Ca
ggplot(data = zab_hydrochemia, aes(date,ca))+
  geom_line()


#wykres: x = czas, y= wartość Ca serie pokolorowane -glebokość
ggplot(data = zab_hydrochemia, aes(date,ca, colour = depth))+
  geom_line()

#wykres: x = czas, y= wartość Ca serie pokolorowane -glebokość  jako wartości dysktetne
ggplot(data = zab_hydrochemia, aes(date,ca, colour =factor(depth)))+
  geom_line()

#wykres: x = czas, y= wartość Ca serie pokolorowane -glebokość  jako wartości dysktetne na 2 wykresach
ggplot(data = zab_hydrochemia, aes(date,ca,colour =factor(depth)))+
  geom_line()+
  facet_wrap(vars(depth))

#wykres: x = czas, y= wartość Ca serie pokolorowane -glebokość  jako wartości dysktetne na 2 wykresac, brak tał, linie osi
ggplot(data = zab_hydrochemia, aes(date,ca,colour =factor(depth)))+
  geom_line()+
  facet_wrap(vars(depth), ncol = 1)


#wykres: x = czas, y= wartość Ca serie pokolorowane -glebokość  jako wartości dysktetne na 2 wykresac, brak tał, linie osi
ggplot(data = zab_hydrochemia, aes(date,ca,colour =factor(depth)))+
  geom_line()+
  facet_wrap(vars(depth), ncol = 1)+
  theme(panel.background = element_blank())

#Wczytaj dane zab_temp_daily
zab_temp <- read.csv("R/data/Nowy folder/zab_temperature-daily.csv") |>
  mutate(day=ymd(day))
#Wykres temp wody w czasie na pierwszym metrze , pinkty, linia wygladzona
ggplot(zab_temp, aes(day,temp_01))+
  geom_point()+
  geom_line(color="red")+
  geom_smooth()

#Wykres z seriami rozbitymi na panele, wzystkie głębokości
zab_temp_pivot <- zab_temp |>
  pivot_longer(cols = temp_01:temp_40,names_to = "glebokosc", values_to = "wartosc")

ggplot(zab_temp_pivot, aes(day,wartosc))+
  geom_line()+
  facet_wrap(vars(glebokosc), ncol=1, scales = "free")

#Wczytaj dane dotyczące pułapki sedymentacyjnej
zab_trap <- read.csv("R/data/Nowy folder/zab_sediment-trap_hypolimnion.csv") |>
  mutate(date= ymd(date))

#Wykres kolumnowy temp akumulacji masy
zab_trap |>
  ggplot(aes(date, mar))+
  geom_col()


#Wykres kolumnowy temp akumulacji masy
wektor <- lag(zab_trap$date)
zab_trap |>
  ggplot()+
  geom_rect(aes(xmin = wektor, xmax = date, ymin = 0, ymax=mar))

#BOX PLOT
ggplot(zab_hydrochemia)+
  geom_boxplot(aes(y=ca, group = depth))+
  facet_wrap(vars(depth))

#violinplot
ggplot(zab_hydrochemia)+
  geom_violin(aes(y = ca,x=factor(depth)))

ggplot(zab_hydrochemia)+
  geom_histogram(aes(ca, fill = factor(depth)))
