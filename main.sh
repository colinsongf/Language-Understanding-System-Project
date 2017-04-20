#!/bin/bash
## Project: LUS Spring project
## @author Federico Marinelli - federico.marinelli@studenti.unitn.it

## -- MAIN.SH --
## Input: [1] - order size
##        [2] - method
##        [3] - some text for the saving
##        [2] - threshold for noise-cutoff smoothing

#init variables with defaults values
order=${1:-"4"}
method=${2:-"kneser_ney"}
text=${3:-""}
treshold=${4:-"0"}

#running word_to_concept script
sh word_to_concept/word_to_concept.sh $treshold

#running the script that generates the language model
sh language_model/generate_lm.sh $order $method

#evaluating the classifer
cd evaluate
python main.py

#print the result on the console
cat results




