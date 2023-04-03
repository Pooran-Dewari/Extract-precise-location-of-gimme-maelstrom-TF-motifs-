#!/usr/bin/env nextflow
nextflow.enable.dsl=2

params.input = "beds/*.bed"
params.pfm = file("nonredundant.motifs.pfm")
params.nr_count = file("motif.nr.count.txt")

params.gimme_scan_bed_files = './results/gimme_extract/*/*.bed'
params.coord_bed_files = './results/motifs_nr_coord/*.bed'
params.outdir = './results/intersect'

process GIMME_SCAN {
    publishDir 'results/gimme_scan', mode: 'copy', overwrite: false

    input:
    path BED
    path PFM
    
    output:
    file ("${BED}_gimme.scan.bed")

    script:
    """
    gimme scan $BED -g Ssal_v3.1 -p $PFM -f 0.05 -b > ${BED}_gimme.scan.bed
    """
}


process EXTRACT_GIMME {
    publishDir 'results/gimme_extract', mode: 'copy', overwrite: false

    input:
    path gimme_scan_file
 
    output:
    path '*'

    script:
    """
    Rscript '$baseDir/gimmeScan_extract_motifs.R' $gimme_scan_file gimme_extract
    """
}

process EXTRACT_NR_MOTIFS {
    publishDir 'results/', mode: 'copy', overwrite: false

    input:
    path nr_count

    output:
    path '*'

    script:
    """
    Rscript '$baseDir/maelstrom_extract_motifs.R' $nr_count
    """
}


process INTERSECT {

    tag { scan_id }

    publishDir "${params.outdir}", mode: 'copy'

    input:
    tuple val(scan_id), path('bed_dir/*')
    path 'coord_dir/*'

    output:
    tuple val(scan_id), path("${scan_id}/*")

    shell:
    '''
    mkdir "!{scan_id}"
    for bed in bed_dir/*; do

        bedtools intersect \\
            -a "${bed}" \\
            -b "coord_dir/$(basename "${bed}")" \\
            -wa |
        sort \\
            -u \\
            > "!{scan_id}/$(basename "${bed}" '.bed')_intersected.bed"
    done
    '''
}

workflow {
    input_ch = Channel.fromPath(params.input)
    pfm_file = params.pfm
    nr_count_file = params.nr_count

    GIMME_SCAN(input_ch, pfm_file)
    EXTRACT_GIMME(GIMME_SCAN.out.flatten())
    EXTRACT_NR_MOTIFS(nr_count_file)
    
    Channel
        .fromFilePairs( params.gimme_scan_bed_files, size: -1) {
            it.parent.name.substring(it.parent.name.lastIndexOf('_') + 1)
        }
        .set { gimme_scan_bed_files }

    Channel
        .fromPath( params.coord_bed_files )
        .collect()
        .set { coord_bed_files }

    INTERSECT(gimme_scan_bed_files, coord_bed_files)
}
