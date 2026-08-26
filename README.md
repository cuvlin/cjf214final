# Effects of Hurricane Disturbance on Stream Ion Conecentrations: Data and Analysis Code from 8 Sites
![Figure 3 of Shaefer Et al. 2000](shaefer_fig3.png)

# Purpose
This repository aims to recreate the analysis used to create the figure as seen above. The figure is from a reserach paper that looked into the effects of hurricane disturbance on stream ion concentration, over time, in several different sites in tropical regions. More specifically, this study looks into the effect of Hurricane Hugo on tributary streams in Bisley, Puerto Rico on a decadal scale. For our intents and purposes, we are restricting the analysis to only the four sites listed in the legend of the above figure. These sites are Quebradas 1, 2, 3 (BQ1, BQ2, NQ3), and Puente Roto Mameyes (PRM). The specific ions that we are looking at are potassium (k), magnesium (mg), calcium (ca), nitrate (no3), and ammonium (nh4).

# Structure

## /data
Thanks to the [Environmental Data Initiative](https://eds-214-reproducibility-m26.github.io/course-materials/interactive/edirepository.org) we have access to the original data used in the original study. As stated earlier, for our repository we are only focused on recreating figure 3 from Shaefer, which is only subset of the raw data. However, the /data folder ONLY contains raw, unedited data. All data loading and analysis will be found within subsequent folders, such as /analysis_code and /scratch. All raw data necessary for the code will be provided in this folder

## /analysis_code
In this folder lives all the finished analysis code used to recreate the Shaefer figure. Each script will be labled with a number, 01 to n, based on the order in which an observer would need to run the code in order to be able to reproduce the figure for themselves. All necessary data uploading and cleaning will be present within the script in which it is used for analysis.

In our code, there is a bit of cleaning involved with this dataset. First, we must extract only data from the four desired sites (BQ1, BQ2, BQ3, BQ4, PRM). Then, we apply a 9-week moving average to each dataset to get cleaner data points. In the end, this gives us a roughly 10 year time series with ion concentration data points at a 9 week interval.

## /R
Contains all the functions needed for the analysis of my data. It will be called within the /analysis_code scripts. The function 'moving_average.R' takes the raw data, over about a decade, and avergaes the ion concentrations at each site based on a 9 week window. This filters our data and allows us to have cleaner plots with far less noise due to day-to-day variability. This gives us a more accurate time series at this time scale.

## /scratch
This folder contains out scratch code for the project. Although not intended to be used for the main data analysis, lots of our thought process regarding the work flow with the data. The code in here may not be comprehensible, and therefore should not be given too much thought. Intermediate steps are found here, but the final scripts, again, will be found in /analysis_code

# References
Data Reference:
Schaefer, Douglas. A., William H. McDowell, Fredrick N. Scatena, and Clyde E. Asbury. 2000. “Effects of Hurricane Disturbance on Stream Water Concentrations and Fluxes in Eight Tropical Forest Watersheds of the Luquillo Experimental Forest, Puerto Rico.” Journal of Tropical Ecology 16 (2): 189–207. https://doi.org/10.1017/s0266467400001358.