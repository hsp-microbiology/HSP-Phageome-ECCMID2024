# HSP-Phageome-ECCMID2024

## Bacterial OTU assignment

The Bacterial OTU assignment  has been perfomed in Gaia Software from Sequentia.SL

## Phageome OTU assignment

The Phageome analysis has been performed using the nextflow available at Shell_analysis.nf in this repository. To perform the analysis install in your linux shell the following program:

[Nextflow](https://github.com/nextflow-io/nextflow)

[BBduk](https://github.com/BioInfoTools/BBMap) from BBmap tools.

[Bowtie2](https://github.com/BenLangmead/bowtie2)

[Kraken2](https://github.com/DerrickWood/kraken2)

### To run in conda environtment

    ##### Create the conda environtment
    conda env create Phageome_pipeline
    conda activate Phageome_pipeline
    ###### Install all the utils
    conda install -c bioconda nextflow
    conda install -c bioconda bbmap
    conda install -c bioconda bowtie2
    conda install -c bioconda kraken2

### Database needed

[Human genome (GRch38)](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000001405.26/)

[Virus Catalog database](https://www.nature.com/articles/s41564-021-00928-6)

## Statistical Analysis

All the estatistical analysis it is available at Viral_Analisis.R


> [!IMPORTANT]
> Check all the packages in Functions are updated.

