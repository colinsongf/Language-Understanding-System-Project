#!/bin/bash
export PYTHONPATH=/path/where/rnn_slu/is:$PYTHONPATH

#train
python rnn_slu/lus/rnn_lstm_train.py rnn_slu/data/tmp/train.data rnn_slu/data/tmp/validation.data \
 rnn_slu/data/tmp/word_dict.data rnn_slu/data/tmp/label_dict.data rnn_slu/config_lstm.cfg model_lstm


python rnn_slu/lus/rnn_lstm_test.py model_lstm rnn_slu/data/test.data rnn_slu/data/tmp/word_dict.data rnn_slu/data/tmp/label_dict.data rnn_slu/config_lstm.cfg results_lstm.txt
./conlleval.pl < results.txt 