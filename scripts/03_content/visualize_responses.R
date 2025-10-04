################################################################################
#
# Juan Carlos Villaseñor-Derbez
# jc_villasenor@miami.edu
# Oct 3, 2025 
#
# Build two panel plots for my visuals. One for Likert scale questions and one
# for binary questions.
#
################################################################################

# SET UP #######################################################################

## Load packages ---------------------------------------------------------------
library(tidyverse)

## Load data -------------------------------------------------------------------
responses <- read_rds("data/processed/clean_responses_long.rds")

# VISUALIZE ####################################################################

## Build a plot ----------------------------------------------------------------
p1 <- ggplot(data = responses |> filter(scale == "Likert"),
            mapping = aes(x = response, y = n)) +
  geom_col(fill = "steelblue", color = "black") + 
  facet_wrap(vars(question_text),
             ncol = 1) +
  theme_minimal(base_size = 14) +
  labs(x = "Response",
       y = "N Responses")

p2 <- ggplot(data = responses |> filter(scale == "Binary"),
            mapping = aes(x = response, y = n)) +
  geom_col(fill = "steelblue", color = "black") + 
  facet_wrap(vars(question_text),
             ncol = 1) +
  theme_minimal(base_size = 14) +
  labs(x = "Response",
       y = "N Responses")

# EXPORT #######################################################################
## Export the likert plot ------------------------------------------------------
ggsave(plot = p1,
       filename = "results/img/likert_responses.png",
       width = 8,
       height = 10)
## Export the binary plot ------------------------------------------------------
ggsave(plot = p2,
       filename = "results/img/binary_responses.png",
       width = 7,
       height = 10)
