# Sequence Labelling using Stochastic Final State Transducers

University of Trento - *Language Understanding Systems Course* - Federico Marinelli (187419)

The extraction of ﬂat concepts out of a given word sequence is usually one of the ﬁrst steps in building a spoken language understanding (SLU) or dialogue system. This project aims to evaluate the performance of labelling a word sequence using Stochastic Final State Transducers, adopting different features, smoothing algorithms, and other techniques in order to improve the baseline performances.

## Prerequisites

In order to use the code developed into this project you need the following tools:

* [OpenGrm](http://www.openfst.org/twiki/bin/view/GRM/NGramLibrary) - The OpenGrm NGram library is used for making and modifying n-gram language models encoded as weighted finite-state transducers (FSTs).
* [OpenFst](http://www.openfst.org/twiki/bin/view/FST/WebHome) - OpenFst is a library for constructing, combining, optimizing, and searching weighted finite-state transducers (FSTs)


## Running the system

It's possible to run the system, with defaults setting, as follow:
 ```
git clone https://github.com/feedmari/LUS-Spring-Project.git
cd LUS-Spring-Project
./main.sh
```

Parameters main.sh:

* **Order** - The size of the n-grams for the language model

* **Method** - The smoothing algorithm to use. (i.e. kneser-ney, witten-bell, unsmoothed, absolute)

* **Frequency Cut-Off** - If 0 it's not active. If > 1 then it corresponds to the frequency cut-off treshold applyed into the word_to_concept machine.

This is an example:
```
./main.sh 3 kneser_ney
```

### Folders Description

#### /data
 Into this folder I put all the train-sets that I've used during this project. The file NLSPARQL.train.data cointained into /data is the one that gave the best results. In the sub-folders is possible to find all the train-sets that I used and gave me worse performances. For more details take a look at the report.

#### /word_to_concept

Into this folder is possible to find all the files and scripts related to the likelihood machine.

#### /language_model

This folder contais the script that generates the Language Model.

#### /evaluate

This folder contais the script used for the evaluation.
In particular we used a third-part script named conlleval for the evaluation.


## Author

* **Federico Marinelli** - [federico.marinelli@studenti.unitn.it](mailto:federico.marinelli@studenti.unitn.it)

