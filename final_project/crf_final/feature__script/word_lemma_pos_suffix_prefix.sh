## Project: LUS final project
## @author Federico Marinelli - federico.marinelli@studenti.unitn.it


cd ..

cat data/NLSPARQL.train.feats.txt | cut -f 1,3 > word_lemma
cat data/NLSPARQL.train.feats.txt | cut -f 2 > pos
cat data/NLSPARQL.train.data | cut -f 2 > label
paste word_lemma pos > word_lemma_pos
paste word_lemma_pos data/suffix/suffix_train1 data/suffix/suffix_train2  data/suffix/suffix_train3 > word_lemma_pos_s
paste data/prefix/prefix_train1 data/prefix/prefix_train2  data/prefix/prefix_train3 > word_lemma_pos_p
paste word_lemma_pos_s word_lemma_pos_p label > complete_train

cat data/NLSPARQL.test.feats.txt | cut -f 1,3 > word_lemma
cat data/NLSPARQL.test.feats.txt | cut -f 2 > pos
cat data/NLSPARQL.test.data | cut -f 2 > label
paste word_lemma pos > word_lemma_pos
paste word_lemma_pos data/suffix/suffix_test1 data/suffix/suffix_test2  data/suffix/suffix_test3 > word_lemma_pos_s
paste data/prefix/prefix_test1 data/prefix/prefix_test2  data/prefix/prefix_test3 > word_lemma_pos_p
paste word_lemma_pos_s word_lemma_pos_p label > complete_test


crf_learn templates/pos_lemma_sp.template complete_train crf.lm

crf_test -m crf.lm complete_test > to_test.txt

perl evaluate/conlleval.pl -d '\t' < to_test.txt 

rm word_lemma
rm pos
rm word_lemma_pos
rm to_test
rm word_lemma_pos_s
rm word_lemma_pos_p
rm complete_test
rm complete_train
rm crf.lm