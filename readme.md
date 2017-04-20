# Sequence Labelling using Stochastic Final State Transducers (SFSTs)

University of Trento - *Language Understanding Systems Course* - Federico Marinelli

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

### Parameters main.sh

* Order - The size of the n-grams for the language model

* Method - The smoothing algorithm to use. (i.e. kneser-ney, witten-bell, unsmoothed, absolute)


This is an example:
```
./main.sh 3 kneser_ney
```

## Author

* **Federico Marinelli** - [e-mail](mailto:federico.marinelli@studio.unitn.it)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

