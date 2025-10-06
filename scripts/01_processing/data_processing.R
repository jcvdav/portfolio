################################################################################
#
# Juan Carlos Villaseñor-Derbez
# jc_villasenor@miami.edu
# Oct 3, 2025
#
# This script reads the raw CSV data from the mid-term survey and cleans it up
# for analyses. It also produces a dictionary of question # and question text
# and a long-format version of the data to help with visualization.
#
################################################################################

# SET UP #######################################################################

## Load packages ---------------------------------------------------------------
library(tidyverse)
library(janitor)

## Load data -------------------------------------------------------------------
responses <- read_csv(file = "data/raw/628/528 Feedback form.csv") |> 
  clean_names()

# Get to know my data
dim(responses) # Check dimensions
colnames(responses) # Check column names (these are terrible)

# PROCESSING ###################################################################

# The data contain 21 responses (rows) and 11 columns (timestamp + 10 questions)
# the 10th question was open ended and I will not analyze it here (but I did
# pay attention to your comments, don't worry...). I will now build a pipeline
# that cleans up the column names and excludes the last one.

## Modify column names ---------------------------------------------------------
clean_responses <- responses |> 
  select(-11) |> # Remove the last column
  rename(id = timestamp,
         q1 = 2, # I don't want to write out the entire column name, so I use the position instead
         q2 = 3,
         q3 = 4,
         q4 = 5,
         q5 = 6,
         q6 = 7,
         q7 = 8,
         q8 = 9,
         q9 = 10) # Q9 is the last question I want to keep, because Q10 is open ended

# Inspect my new tibble
clean_responses

# The new names are easier to work with, but give me no information about what
# the question was. I will therefore use the full questions that are still 
# stored in the names of the `responses` object (the "raw" one) to build a
# new tibble that I can use as a dictionary further down the line. The new
# tibble will have two columns, one with question numbers and one with full
# questions. There will be nine column names.

## Get questions as variables --------------------------------------------------
questions <- tibble(question_number = paste0("q", 1:9),                # paste0() allows me to paste strings of text without spaces in between
                    question_text = colnames(responses[2:10])) |>      # Here I extract the 9 column names I care about from the original data
  # You have not seen these yet, but I am doing a bit of text manipulation here
  mutate(question_text = str_replace_all(question_text, "_", " "),     # This basically undoes the clean_names conversion, swapping every underscore for a space
         question_text = str_to_sentence(question_text),               # This converts lowercase text to sentence case text
         question_text = str_replace_all(question_text, " i ", " I ")) # And this finds any "i" that is standing between spaces (so, the first person singular pronoun I) and capitalizes it

# Inspect my new questions tibble
questions

# A long-version of my data ----------------------------------------------------
# Finally, I want to have a data set that I can use to quickly plot things out.
# This one will deviate a bit from a "tidy" data structure, but remember you
# can always deviate from guidelines if it makes your life easier. You will later
# see why this is easier.

long_responses <- clean_responses |> 
  mutate_all(as.character) |> 
  pivot_longer(cols = starts_with("q"),
               names_to = "question",
               values_to = "response") |> 
  group_by(question, response) |> 
  summarise(n = n()) |> 
  ungroup() |> 
  mutate(scale = ifelse(question %in% c("q1", "q2", "q3", "q4", "q5"), "Likert", "Binary")) |> 
  left_join(questions, by = join_by(question == question_number)) |> 
  mutate(question_text = fct_reorder(question_text, question, min)) |> 
  select(question, question_text, scale, response, n)

long_responses

# EXPORT #######################################################################

## Export the file(s) ----------------------------------------------------------
write_rds(x = clean_responses,
          file = "data/processed/clean_responses.rds")
write_rds(x = questions,
          file = "data/processed/questions.rds")
write_rds(x = long_responses,
          file = "data/processed/clean_responses_long.rds")

