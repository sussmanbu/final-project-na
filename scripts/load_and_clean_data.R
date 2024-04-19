library(data.table)
library(magrittr)
library(dplyr)
library(tidyverse)

## CLEAN the data
ds_2023 <- read_csv("dataset/NYPD.csv",show_col_types = FALSE )|>
  select(-ARREST_KEY,-PD_CD,-KY_CD,-LAW_CODE,-JURISDICTION_CODE) 

na_count <- sum(is.na(ds_2023))
na_count
ds_2023<- na.omit(ds_2023) 
ds_2023 <- ds_2023 |>
  na.omit() |>
  filter(PD_DESC != "(null)")|>
  filter(LAW_CAT_CD != "9")

ds_2022 <-read_csv("dataset/NYPD_2022.csv",show_col_types = FALSE )|>
  select(-ARREST_KEY,-PD_CD,-KY_CD,-LAW_CODE,-JURISDICTION_CODE) 
na_count <- sum(is.na(ds_2022))
na_count
ds_2022 <- na.omit(ds_2022) 
ds_2022 <- ds_2022 |>
  na.omit() |>
  filter(PD_DESC != "(null)")|>
  filter(LAW_CAT_CD != "9")|>
  filter(ARREST_DATE != "TRUE")

ds_2022 %<>% dplyr::rename(`New Georeferenced Column` = Lon_Lat) # different column name

ds <- rbind(ds_2023, ds_2022, use.names=TRUE)

ds <- ds |>
  na.omit() |>
  filter(PD_DESC != "(null)")|>
  filter(LAW_CAT_CD != "9")|>
  filter(ARREST_DATE != "TRUE")

saveRDS(ds, here::here("dataset","load_and_clean_data.rds"))

