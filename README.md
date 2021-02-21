# dataviz-NBA-stereogram
R code to populate an Observable notebook visualizing historical NBA features (age, weight, height) with an 3D stereogram.

Initial datasets downloaded from https://www.kaggle.com/drgilermo/nba-players-stats.

Data crunching in order to have all the data contiguous (in terms of all values for age, weight and height), with all values present in all seasons and summarized into bins so we "smooth" the data and the dataviz does not reveal noise.
