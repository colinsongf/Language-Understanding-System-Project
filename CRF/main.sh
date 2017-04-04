cat data/NLSPARQL.train.feats.txt | cut -f 1,2 > no_lemma.train.feats.txt
cat data/NLSPARQL.train.data | cut -f 2 > only_label.data
paste no_lemma.train.feats.txt only_label.data > with.pos.train.data

cat data/NLSPARQL.test.feats.txt | cut -f 1,2 > test.with.pos.data
cat data/NLSPARQL.test.data | cut -f 2 > test.label.data
paste test.with.pos.data test.label.data > with.pos.test.data

crf_learn crf.template with.pos.train.data crf.lm

crf_test -m crf.lm with.pos.test.data > test.txt

perl conlleval.pl -d '\t' < test.txt