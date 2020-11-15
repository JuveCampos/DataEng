
# install.packages("threejs")
# require(devtools)
# install_github("Displayr/flipChartBasics")

library(threejs)
library(flipChartBasics)

# Read the data and calculate age in years
x = read.csv("https://data.nasa.gov/api/views/gh4g-9sfh/rows.csv")
current = as.numeric(format(Sys.Date(), "%Y"))
x$age = current - as.numeric(substr(x$year, 7, 10))

# Filter the required information
x = x[ , c("reclong", "reclat", "mass..g.", "age")]
colnames(x) = c("long","lat","value", "age")

# Set colors on a scale of 1 to 10 by percentile
colors = as.numeric(cut(x$age,
                        breaks = quantile(x$age, probs = seq(0, 1, 0.1), 
                                          include.lowest = TRUE, na.rm = TRUE)))
palette = ChartColors(10, "Reds", reverse = TRUE)
colors = palette[colors]

# Plot the data on the globe
globejs(lat = x$lat,
        long = x$long,
        val = 2 * log(x$value),
        color = colors,
        pointsize = 0.5,
        atmosphere = TRUE)
