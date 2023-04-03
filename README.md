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
├── nonredundant.motifs.pfm \
