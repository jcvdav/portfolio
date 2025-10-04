################################################################################
#
# Juan Carlos Villaseñor-Derbez
# jc_villasenor@miami.edu
# Oct 3, 2025
#
# Let's focus on one crucial question: Should I give more frequent assignments?
#
################################################################################

# SET UP #######################################################################

## Load packages ---------------------------------------------------------------
library(tidyverse)

## Load data -------------------------------------------------------------------
responses <- read_rds("data/processed/clean_responses.rds") # To analyze
questions <- read_rds("data/processed/questions.rds") # To guide myself

# PROCESSING ###################################################################

# Which question number do I care about?
questions

# I can now see that q8 is the one that talks about assignments. So let's work
# with that one. I want to know what percentage of the class wants more frequent
# assignments. If the number is greater than 50%, I'll hand out more assignments.

## Let's get the answer --------------------------------------------------------
q8_responses <- responses |> 
  select(id, q8) |>  # This retains only the columns I care about
  group_by(q8) |> 
  summarize(n = n()) |> 
  ungroup() |> 
  mutate(pct = (n / sum(n)) * 100)

# The verdict
q8_responses

# Nope, looks like 61.9% of people don't want more assignments.