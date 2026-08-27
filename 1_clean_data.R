library(tidyverse)
source("R/moving_average.R")

# Load in raw data as standalone dataframes and selecting only useful columns
colnames <- c('Sample_Date', 'NH4-N', 'Ca', 'Mg', 'NO3-N', 'K', 'Sample_ID')
PRM_raw <- read_csv("data/lter_data/RioMameyesPuenteRoto.csv") |> # MPR
  select(colnames)
BQ1_raw <- read_csv("data/lter_data/QuebradaCuenca1-Bisley.csv") |> # Q1
  select(colnames)
BQ2_raw <- read_csv("data/lter_data/QuebradaCuenca2-Bisley.csv") |> # Q1
  select(colnames)
BQ3_raw <- read_csv("data/lter_data/QuebradaCuenca3-Bisley.csv") |> # Q3
  select(colnames)

# Use moving_average function
PRM_smoothed <- moving_average(PRM_raw)
BQ1_smoothed <- moving_average(BQ1_raw)
BQ2_smoothed <- moving_average(BQ2_raw)
BQ3_smoothed <- moving_average(BQ3_raw)

# Combine data into 1 dataframe
lter_smoothed <- rbind(PRM_smoothed, BQ1_smoothed, BQ2_smoothed, BQ3_smoothed)
colnames(lter_smoothed) <- c(
  'window_start',
  'K mgl-1',
  'Mg mgl-1',
  'NO3-N ugl-1',
  'NH4-N ugl-1',
  'Ca mgl-1',
  'sample_id'
)

# Turn data into long format to plot easily
lter_smoothed_long <- lter_smoothed |>
  pivot_longer(
    cols = c(
      `K mgl-1`,
      `NO3-N ugl-1`,
      `Mg mgl-1`,
      `Ca mgl-1`,
      `NH4-N ugl-1`
    ),
    names_to = "ions",
    values_to = "window_mean"
  ) |>
  mutate(
    ions = factor(
      ions,
      levels = c(
        'K mgl-1',
        'NO3-N ugl-1',
        'Mg mgl-1',
        'Ca mgl-1',
        'NH4-N ugl-1'
      )
    )
  )
# Export final dataframe to csv file
write_csv(lter_smoothed_long, "output/lter_smoothed_output.csv")
