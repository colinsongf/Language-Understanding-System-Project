#!/bin/bash
## Project: LUS Spring project
## @author Federico Marinelli - federico.marinelli@studenti.unitn.it

order=${1:-"3"}
method=${2:-"witten_bell"}
treshold=${3:-"0"}

sh word_to_concept/word_to_concept.sh $treshold

sh language_model/generate_lm.sh $order $method

python evaluate/main.py

cat evaluate/results

