# Extract-precise-location-of-gimme-maelstrom-TF-motifs
The precise location of TF motifs is missing in gimme maelstrom TFBS outputs. This nextflow pipeline outputs the precise location of TF motifs.


### What files do I need? Follow this directory structure

├── beds \
│   ├── Ss1_12_dense.bed_Act_Enh_12StatesModel.bed \
│   ├── Ss2_12_dense.bed_Act_Enh_12StatesModel.bed \
│   ├── Ss3_12_dense.bed_Act_Enh_12StatesModel.bed \
│   ├── Ss4_12_dense.bed_Act_Enh_12StatesModel.bed \
│   └── Ss5_12_dense.bed_Act_Enh_12StatesModel.bed \
├── extract_motif_loc.nf \
├── gimmeScan_extract_motifs.R \
├── maelstrom_extract_motifs.R \
├── motif.nr.count.txt \
├── nonredundant.motifs.pfm

### How to run the pipeline

```ruby
nextflow run extract_motif_loc.nf 
```
Shouldn't take long to finish and you should see screen output of run summary as follows:
```ruby
nextflow run test_v3.nf
N E X T F L O W  ~  version 22.10.6
Launching `test_v3.nf` [festering_bardeen] DSL2 - revision: bb41e3dd9a
executor >  local (5)
[52/17a139] process > GIMME_SCAN (2)    [100%] 5 of 5 ✔
[46/61caed] process > EXTRACT_GIMME (1) [100%] 5 of 5 ✔
[23/b911e5] process > EXTRACT_NR_MOTIFS [100%] 1 of 1 ✔
[d8/42ae7a] process > INTERSECT (Ss4)   [100%] 5 of 5 ✔

```


