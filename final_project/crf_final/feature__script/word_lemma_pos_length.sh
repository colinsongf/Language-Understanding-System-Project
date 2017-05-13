## Project: LUS final project
## @author Federico Marinelli - federico.marinelli@studenti.unitn.it

cd ..

cat data/NLSPARQL.train.feats.txt | cut -f 1,3 > word_lemma
cat data/NLSPARQL.train.feats.txt | cut -f 2 > pos
cat data/NLSPARQL.train.data | cut -f 2 > label
paste word_lemma pos > word_lemma_pos
paste word_lemma_pos data/word_length_train > word_lemma_pos_length
paste word_lemma_pos_length label > complete_train

cat data/NLSPARQL.test.feats.txt | cut -f 1,3 > word_lemma
cat data/NLSPARQL.test.feats.txt | cut -f 2 > pos
cat data/NLSPARQL.test.data | cut -f 2 > label
paste word_lemma pos > word_lemma_pos
paste word_lemma_pos data/word_length_test > word_lemma_pos_length
paste word_lemma_pos_length label > complete_test

crf_learn templates/pos_lemma_length.template complete_train crf.lm

crf_test -m crf.lm complete_test > to_test.txt

perl evaluate/conlleval.pl -d '\t' < to_test.txt 

rm word_lemma
rm pos
rm word_lemma_pos
rm to_test
