library(tidyverse)


# Loading in Data --------------------------------------------------------

# The four locations that we are looking at are PRM, BQ1, BQ2, and BQ3. IN the raw data, they have different names so we will load them in and rename them.
#Sample_Date, NH4-N, CA, MG, NO3-N, K == names of columns we want
colnames <- c('Sample_Date', 'NH4-N', 'Ca', 'Mg', 'NO3-N', 'K', 'Sample_ID')
PRM_raw <- read_csv("data/lter_data/RioMameyesPuenteRoto.csv") |> # MPR
  select(colnames)
BQ1_raw <- read_csv("data/lter_data/QuebradaCuenca1-Bisley.csv") |> # Q1
  select(colnames)
BQ2_raw <- read_csv("data/lter_data/QuebradaCuenca2-Bisley.csv") |> # Q1
  select(colnames)
BQ3_raw <- read_csv("data/lter_data/QuebradaCuenca3-Bisley.csv") |> # Q3
  select(colnames)

lter_cat <- rbind(PRM_raw, BQ1_raw, BQ2_raw, BQ3_raw)

lter_smoothed <- tibble(
  window_start = seq(ymd("1986-05-20"), ymd("2020-12-29"), by = "63 days"),
  k = NA,
  mg = NA,
  no3_n = NA,
  nh4_n = NA,
  ca = NA,
  sample_id = NA
)

# 9 Week Smoothed Average

for (i in 1:length(lter_smoothed$window_start)) {
  ws <- lter_smoothed$window_start[i]
  we <- lter_smoothed$window_start[i] + 63
  # for K
  lter_smoothed$k[i] <- mean(
    lter_cat$K[lter_cat$sample_date >= ws & lter_cat$sample_date < we],
    na.rm = TRUE
  )
  # for mg
  lter_smoothed$mg[i] <- mean(
    lter_cat$Mg[lter_cat$sample_date >= ws & lter_cat$sample_date < we],
    na.rm = TRUE
  )
  # for ca
  lter_smoothed$ca[i] <- mean(
    lter_cat$Ca[lter_cat$sample_date >= ws & lter_cat$sample_date < we],
    na.rm = TRUE
  )
  # for nh4
  lter_smoothed$nh4_n[i] <- mean(
    lter_cat$'NH4_N'[lter_cat$sample_date >= ws & lter_cat$sample_date < we],
    na.rm = TRUE
  )
  # for no3
  lter_smoothed$no3_n[i] <- mean(
    lter_cat$'NO3-N'[lter_cat$sample_date >= ws & lter_cat$sample_date < we],
    na.rm = TRUE
  )
  # For sample ID
  lter_smoothed$sample_id[i] <- first(
    lter_cat$Sample_ID[lter_cat$sample_date >= ws & lter_cat$sample_date < we]
  )
}

lter_cat |>
  ggplot(
    mapping = aes(x = Sample_Date, y = Ca, fill = Sample_ID)
  ) +
  geom_point() +
  theme_minimal()


# 9 Week Average using filters -------------------------------------------

test_smoothed_workbench <- tibble(
  window_start = seq(ymd("1986-05-20"), ymd("2020-12-29"), by = "63 days"),
  k = NA,
  mg = NA,
  no3_n = NA,
  nh4_n = NA,
  ca = NA,
  Sample_Id = NA
)
