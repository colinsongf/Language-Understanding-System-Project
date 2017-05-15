#!/bin/bash
export PYTHONPATH=/path/where/rnn_slu/is:$PYTHONPATH

#train
python rnn_slu/lus/rnn_jordan_train.py rnn_slu/data/tmp/train.data rnn_slu/data/tmp/validation.data \
 rnn_slu/data/tmp/word_dict.data rnn_slu/data/tmp/label_dict.data rnn_slu/config.cfg model_jordan


python rnn_slu/lus/rnn_jordan_test.py model_jordan rnn_slu/data/test.data rnn_slu/data/tmp/word_dict.data rnn_slu/data/tmp/label_dict.data rnn_slu/config.cfg results_jordan.txt
./conlleval.pl < results.txt 