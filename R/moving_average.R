moving_average <- function(raw_data) {
  if (raw_data$Sample_ID[1] == "Q1") {
    sample_id <- "BQ1"
  } else if (raw_data$Sample_ID[1] == "Q2") {
    sample_id <- "BQ2"
  } else if (raw_data$Sample_ID[1] == "Q3") {
    sample_id <- "BQ3"
  } else if (raw_data$Sample_ID[1] == "MPR") {
    sample_id <- "PRM"
  }

  smoothed_data <- tibble(
    window_start = seq(ymd("1988-01-01"), ymd("1994-12-31"), by = "63 days"),
    k = NA,
    mg = NA,
    no3_n = NA,
    nh4_n = NA,
    ca = NA,
    sample_id = sample_id
  )

  for (i in 1:length(smoothed_data$window_start)) {
    ws <- smoothed_data$window_start[i]
    we <- smoothed_data$window_start[i] + 63

    # for k
    smoothed_data$k[i] <- mean(
      raw_data$K[raw_data$Sample_Date >= ws & raw_data$Sample_Date < we],
      na.rm = TRUE
    )

    # for mg
    smoothed_data$mg[i] <- mean(
      raw_data$Mg[raw_data$Sample_Date >= ws & raw_data$Sample_Date < we],
      na.rm = TRUE
    )

    # for ca
    smoothed_data$ca[i] <- mean(
      raw_data$Ca[raw_data$Sample_Date >= ws & raw_data$Sample_Date < we],
      na.rm = TRUE
    )

    # for nh4
    smoothed_data$nh4_n[i] <- mean(
      raw_data$`NH4-N`[raw_data$Sample_Date >= ws & raw_data$Sample_Date < we],
      na.rm = TRUE
    )

    # for nh4
    smoothed_data$no3_n[i] <- mean(
      raw_data$`NO3-N`[raw_data$Sample_Date >= ws & raw_data$Sample_Date < we],
      na.rm = TRUE
    )
  }
  return(smoothed_data)
}
# comment to make a change in git hub
