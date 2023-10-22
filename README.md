# HSP-Phagome-ECCMID2024

## Bacterial OTU assignment

The Bacterial OTU assignment  has been perfomed in Gaia Software from Sequentia.SL

## Phagome OTU assignment

The Phagome analysis has been performed using the nextflow available at Shell_analysis.nf in this repository. To perform the analysis install in your linux shell the following program:

[Nextflow](https://github.com/nextflow-io/nextflow)

[BBduk](https://github.com/BioInfoTools/BBMap) from BBmap tools.

[Bowtie2](https://github.com/BenLangmead/bowtie2)

[Kraken2](https://github.com/DerrickWood/kraken2)

### To run in conda environtment

    ##### Create the conda environtment
    conda env create Phagome_pipeline
    conda activate Phagome_pipeline
    ###### Install all the utils
    conda install -c bioconda nextflow
    conda install -c bioconda bbmap
    conda install -c bioconda bowtie2
    conda install -c bioconda kraken2

### Database needed

Human genome (GRch38):
Virus Catalog database:

## Statistical Analysis

All the estatistical analysis it is available at Viral_Analisis.R
