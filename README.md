# Evaluating survey responses

This repository serves two purposes. First, as an example for your second assignment on
data management and transformation. And second, to provide the results from the
mid-term feedback you provided.


## Repository structure

The repository contains three main folders:

- `data`:
  - `data/raw` contains the `*.csv` file as downloaded from google forms.
  - `data/processed` contains the cleaned up version of my data
- `scripts`
  - `scripts/01_processing` contains a single script that reads the raw data, cleans it up, and exports processed data.
  - `scripts/02_analyses` 
  - `scripts/03_contents` contains a single script that builds two figures, shown below
- `results` contains a folder with images

## About the data

### `data/processed/clean_responses.rds` contains 21 rows and 10 columns:

- `id` - Character - A unqiue identifier for each survey response, recorded as the timestmap
- `q1` - Numeric - Uses a Likert scale (1-5) to record responses to q1
- `q2` - Numeric - Uses a Likert scale (1-5) to record responses to q2
- `q3` - Numeric - Uses a Likert scale (1-5) to record responses to q3
- `q4` - Numeric - Uses a Likert scale (1-5) to record responses to q4
- `q5` - Numeric - Uses a Likert scale (1-5) to record responses to q5
- `q6` - Character - Options are `"Agree"` and `"Disagree"`, in responses to q6
- `q7` - Character - Options are `"Agree"` and `"Disagree"`, in responses to q7
- `q8` - Character - Options are `"Agree"` and `"Disagree"`, in responses to q8
- `q9` - Character - Options are `"Agree"` and `"Disagree"`, in responses to q9

A list of question numbers and questions is available in `data/processed/questions.rds`, and below:

- q1: How much have you learned                                                                          
- q2: The pace of the lectures so far has been appropriate for my learning                               
- q3: The pace of coding sessions so far has been appropriate for my learning                            
- q4: The contents covered are                                                                           
- q5: I have met the learning objectives presented during lectures and worked on during the live coding sessions
- q6: I feel more confident working in r studio now compared to the start of the semester                
- q7: I understand the importance of reproducibility and good data practices in science                  
- q8: I would like to have more frequent assignments                                                     
- q9: Overall I am glad I am taking this course and I would recommend it to other students

## Results

![Responses to questions using a 1:5 scale](results/img/likert_responses.png)

![Responses to questions using a binary scale](results/img/binary_responses.png)