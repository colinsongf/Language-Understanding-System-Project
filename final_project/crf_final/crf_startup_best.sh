## Project: LUS final project
## @author Federico Marinelli - federico.marinelli@studenti.unitn.it

#creating the train set with features [ lemma - pos - prfix - suffix - label]
cat data/NLSPARQL.train.feats.txt | cut -f 1,3 > word_lemma
cat data/NLSPARQL.train.feats.txt | cut -f 2 > pos
cat data/NLSPARQL.train.data | cut -f 2 > label
paste word_lemma pos > word_lemma_pos
paste word_lemma_pos data/prefix/prefix_train3  data/suffix/suffix_train3 > word_lemma_pos_s
paste word_lemma_pos_s label > complete_train


#creating the test set with features [ lemma - pos - prfix - suffix - label]
cat data/NLSPARQL.test.feats.txt | cut -f 1,3 > word_lemma
cat data/NLSPARQL.test.feats.txt | cut -f 2 > pos
cat data/NLSPARQL.test.data | cut -f 2 > label
paste word_lemma pos > word_lemma_pos
paste word_lemma_pos data/prefix/prefix_test3 data/suffix/suffix_test3 > word_lemma_pos_s
paste word_lemma_pos_s label > complete_test

#training crf [TEMPLATE PATH: templates/pos_lemma_sp3.template]
crf_learn templates/pos_lemma_sp3.template complete_train crf.lm

#testing crt
crf_test -m crf.lm complete_test > to_test.txt

#evaluating with conlleval
perl evaluate/conlleval.pl -d '\t' < to_test.txt 

#cleaning up
rm word_lemma
rm pos
rm word_lemma_pos
rm to_test
rm word_lemma_pos_s
rm word_lemma_pos_p
rm complete_test
rm complete_train
rm crf.lm
