### Recurisive Neural Networks (RNNs) for Spoken Language Understanding

Based on the papers:

[Grégoire Mesnil, Xiaodong He, Li Deng and Yoshua Bengio - **Investigation of Recurrent Neural Network Architectures and Learning Methods for Spoken Language Understanding**](http://www.iro.umontreal.ca/~lisa/pointeurs/RNNSpokenLanguage2013.pdf)

[Grégoire Mesnil, Yann Dauphin, Kaisheng Yao, Yoshua Bengio, Li Deng, Dilek Hakkani-Tur, Xiaodong He, Larry Heck, Gokhan Tur, Dong Yu and Geoffrey Zweig - **Using Recurrent Neural Networks for Slot Filling in Spoken Language Understanding**](http://www.iro.umontreal.ca/~lisa/pointeurs/taslp_RNNSLU_final_doubleColumn.pdf)

## Code

This code allows to get state-of-the-art results and a significant improvement
(+1% in F1-score) with respect to the results presented in the paper.

In order to reproduce the results, make sure Theano is installed and the
repository is in your `PYTHONPATH`.


Configuration file:
-------------------

The following parameters can be set by using the configuration file: (See the config.cfg file)

```
lr: starting learning rate
win: context window size
bs: mini batch size
nhidden: size of the hidden layer
seed: random seed
emb_dimension: dimension of the word embeddings
nepochs: maximum number of backpropagation steps
```

Train and Test Elman RNN:
-------------------

```
sh startup_elman.sh
```

Train and Test Jordan RNN:
--------------------

```
sh startup_jordan.sh
```

Train and Test LSTM RNN:
--------------------
It will automatically use the best configuration settings that I found for them.
```
sh startup_lstm.sh
```


