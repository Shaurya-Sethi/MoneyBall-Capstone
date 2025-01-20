# MoneyBall Analysis Project

## Overview
This project, inspired by the "Moneyball" philosophy, applies statistical analysis to identify cost-effective baseball players who can serve as suitable replacements for key players lost by the Oakland Athletics in 2001. We focus on leveraging advanced baseball statistics to maximize team performance relative to financial expenditure.

## Data Sources
We utilized two primary datasets in this analysis:
- **Batting Statistics:** This dataset includes player batting statistics, providing insights into individual performance metrics such as hits, home runs, and batting averages.
- **Salaries:** This dataset contains the salary information for players, crucial for assessing cost-effectiveness.

Both datasets were sourced from the Lahman Baseball Database and filtered for the analysis of players post-1985 to align with modern baseball conditions.

## Methodology
### Data Preparation
Data was imported using `data.table` and `dplyr` packages in R, allowing for efficient manipulation and merging of large datasets. The batting and salary data were combined to provide a comprehensive view of player performance and economic value.

### Feature Engineering
We calculated several advanced metrics to better assess player value:
- **Batting Average (BA)**
- **On-base Percentage (OBP)**
- **Slugging Percentage (SLG)**
These metrics offer a more complete understanding of a player's offensive contributions beyond traditional statistics.

### Statistical Analysis
Using a custom function, we identified potential replacement players who match or exceed the performance of the players lost in 2001, while also remaining within the designated salary cap. The function iterates through combinations of players to find the best match based on combined salary, aggregate at-bats, and average OBP.

## Visualizations
Interactive visualizations were created using `ggplot2` and `plotly`:
- **Performance Efficiency of Replacement Players:** Scatter plot showing the salary versus slugging percentage of potential replacements.
- **Comparison of On-base, Batting, and Slugging Percentages:** Box plots comparing these key metrics between lost and replacement players.

## Results
The analysis successfully identified a set of players who could potentially replace the lost talent with minimal financial impact, while maintaining or improving team performance metrics.

## Conclusion
The project demonstrates the power of data-driven decision-making in sports management, providing a framework for baseball teams to achieve competitive advantage through analytics.

## Code
The R scripts used in this project are structured for reproducibility and can be run to perform the analysis from start to finish. Users are encouraged to adapt the methodology for other teams or scenarios within sports analytics.

## How to Run
Ensure you have R installed and the following packages: `data.table`, `dplyr`, `ggplot2`, `plotly`, `knitr`, `kableExtra`. Clone this repository and run the scripts in your R environment to reproduce the analysis and visualizations.

## Authors
- Shaurya Sethi

## Acknowledgments
- Lahman Baseball Database for providing the datasets used in this analysis.

