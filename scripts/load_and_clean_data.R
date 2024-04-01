# This file is purely as an example. 
# There are a few places

library(tidyverse)


## CLEAN the data
ds <- read_csv("dataset/NYPD.csv",show_col_types = FALSE )|>
  select(-ARREST_KEY,-PD_CD,-KY_CD,-LAW_CODE,-ARREST_BORO,-JURISDICTION_CODE) 

na_count <- sum(is.na(ds))
na_count
ds <- na.omit(ds) 
ds <- ds |>
  na.omit() |>
  filter(PD_DESC != "(null)")|>
  filter(LAW_CAT_CD != "9")


saveRDS(ds, "dataset/load_and_clean_data.rds")