## Project: LUS final project
## @author Federico Marinelli - federico.marinelli@studenti.unitn.it

cd ..

cat data/NLSPARQL.train.feats.txt | cut -f 1,3 > no_lemma.train.feats.txt
cat data/NLSPARQL.train.data | cut -f 2 > only_label.data
paste no_lemma.train.feats.txt only_label.data > with.pos.train.data

cat data/NLSPARQL.test.feats.txt | cut -f 1,3 > test.with.pos.data
cat data/NLSPARQL.test.data | cut -f 2 > test.label.data
paste test.with.pos.data test.label.data > with.pos.test.data

crf_learn crf.template with.pos.train.data crf.lm

crf_test -m crf.lm with.pos.test.data > test.txt

perl conlleval.pl -d '\t' < test.txt 

rm no_lemma.train.feats.txt
rm only_label.data
rm with.pos.train.data
rm test.with.pos.data
rm test.label.data
rm with.pos.test.data
rm crf.lm
rm test.txt