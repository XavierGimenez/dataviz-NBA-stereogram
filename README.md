# dataviz-NBA-stereogram
R code to populate an Observable notebook visualizing historical NBA features (age, weight, height) with an 3D stereogram.

### Data visualization in this Observable notebook:
https://observablehq.com/@xavigimenez/stereogram-dataviz-with-nba-historical-data

Initial datasets downloaded from https://www.kaggle.com/drgilermo/nba-players-stats.

Data crunching in order to have all the data contiguous (in terms of all values for age, weight and height), with all values present in all seasons and summarized into bins so we "smooth" the data and the dataviz does not reveal noise.

Inspiration of dataviz come from Luigi Perozzo’s area chart of census data showing the male population of Sweden between 1750 and 1875 by age group, published in an 1880 issue of the Italian statistics journal Annali di Statistica ([more info here](https://www.laphamsquarterly.org/roundtable/instead-writing-thousand-words-part-three)):

![Stereogram](https://github.com/XavierGimenez/dataviz-NBA-stereogram/blob/main/stereogram__historical.png "Stereogram")
