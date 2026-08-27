library(tidyverse)
library(patchwork)
source("R/moving_average.R")

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


# Use moving_average function

PRM_smoothed <- moving_average(PRM_raw)
BQ1_smoothed <- moving_average(BQ1_raw)
BQ2_smoothed <- moving_average(BQ2_raw)
BQ3_smoothed <- moving_average(BQ3_raw)

lter_smoothed <- rbind(PRM_smoothed, BQ1_smoothed, BQ2_smoothed, BQ3_smoothed)
colnames(lter_smoothed) <- c(
  'window_start',
  'K mgl-1',
  'NO3-N ugl-1',
  'Mg mgl-1',
  'Ca mgl-1',
  'NH4-N ugl-1',
  'sample_id'
)

lter_smoothed_long <- lter_smoothed |>
  pivot_longer(
    cols = c(
      'K mgl-1',
      'NO3-N ugl-1',
      'Mg mgl-1',
      'Ca mgl-1',
      'NH4-N ugl-1'
    ),
    names_to = "ions",
    values_to = "window_mean"
  )


lter_smoothed_long |>
  ggplot(
    mapping = aes(
      x = window_start,
      y = window_mean,
      group = sample_id,
      linetype = sample_id
    )
  ) +
  geom_line() +
  theme_linedraw() +
  theme(legend.position.inside = c(1, 1)) +
  facet_grid(vars(lter_smoothed_long$ions), scales = "free", switch = "y") +
  ylab("Ions") +
  xlab("Years") +
  labs(title = "Hurricane Effects on Stream Chemistry", color = "Site")
