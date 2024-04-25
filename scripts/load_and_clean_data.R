library(data.table)
library(magrittr)
library(dplyr)
library(tidyverse)



## CLEAN the data
ds_2023 <- fread("dataset/NYPD.csv") |>
  select(-ARREST_KEY,-PD_CD,-KY_CD,-LAW_CODE,-JURISDICTION_CODE) 

na_count <- sum(is.na(ds_2023))
na_count
ds_2023 <- na.omit(ds_2023) 
ds_2023 <- ds_2023 |>
  na.omit() |>
  filter(PD_DESC != "(null)") |>
  filter(LAW_CAT_CD != "9")

ds_2023 %<>% mutate(ARREST_DATE = lubridate::mdy(ARREST_DATE))


ds_weather <- fread("dataset/weather.csv") %>% 
  select(datetime, temp, windspeed, conditions)

ds <- merge(ds_2023, ds_weather, by.x = 'ARREST_DATE', by.y = 'datetime', all.x = T)

# fwrite(ds, 'ds_merge_data.csv')

ds <- ds |>
  na.omit() |>
  filter(PD_DESC != "(null)")|>
  filter(LAW_CAT_CD != "9") |>
  filter(ARREST_DATE != TRUE)

saveRDS(ds, here::here("dataset","load_and_clean_data.rds"))


