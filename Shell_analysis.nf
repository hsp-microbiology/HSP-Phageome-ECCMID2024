#!/usr/bin/env nextflow


/*
 * Pipeline Metagenomics, conda ambient Metagenomics_Nextflow The conda ambient incled the following packages::: The links could be broken
    * Bbmap https://anaconda.org/bioconda/bbmap
    * Bowtie2 https://anaconda.org/bioconda/bowtie2
    * Samtools https://anaconda.org/bioconda/samtools
    * Kraken2 https://anaconda.org/bioconda/kraken2
 */


 nextflow.enable.dsl=2 // Nextflow version

params.fq1 = "$HOME/../*1.fq.gz" // Can be modified in the script with the --fq1 <value> command | Put read1
params.fq2 = "$HOME/../*2.fq.gz" // Can be modified in the script with the --fq2 <value> command | Put read2
params.db_human = "./GRCh38_latest_genomic.fna"// Can be modified in the script with the --human <value> command | Put bowtie index human genome
params.db_gut = "./Kraken_raw/"// Can be modified in the script with the --db_gut <value> command | Put The Viral gut kraken database folder the database used on these analysis was https://www.nature.com/articles/s41564-021-00928-6
params.otuput_dir = "$HOME/../" // Can be modified in the script with the --otuput_dir <value> command | Put OTU table dir output


/*
 * Check the quality of raw sequences
 */

 process BBduk {

    input:
        path read1
        path read2
    output:
        file("*_1.fq.tr.gz")
        file("*_2.fq.tr.gz")
        file("*.bbduk.log") 

     script:
        def prefix = read1.toString().replaceFirst("_1\\.fq\\.gz\$", "")
        def raw = "in1=${read1} in2=${read2}"
        def trimmed  = "out1=${prefix}_1.fq.tr.gz out2=${prefix}_2.fq.tr.gz"

            """
                bbduk.sh \\
                $raw \\
                $trimmed \\
                qtrim=r trimq=10 minlen=100 \\
                &> ${prefix}.bbduk.log
            """

 }

/*
* Remove the human DNA sequences
*/

 process DNA_clean {

     input:
        path file1
        path file2
        val DB 
    output:
        file "*.R1.fq.gz"
        file "*.R2.fq.gz"
        file "*.Bowtie.log"
    script:
        def prefix = file1.toString().replaceFirst("_1\\.fq\\.tr\\.gz\$", "")
        def entry_bowtie = "-x ${DB} -1 ${file1} -2 ${file2}"
        """
            # Math with the human chromosome
                bowtie2 $entry_bowtie | samtools  view -Sb - > alignment.bam 2 > ${prefix}.Bowtie.log
            # Flag all the mathed Human_DNA
                samtools view -b -f 12 alignment.bam > archivo.filt.bam
            # Create both reads 
                samtools fastq archivo.filt.bam -1 ${prefix}.R1.fq.gz -2 ${prefix}.R2.fq.gz
        """
 }

/*
* Assing the taxonomy for non-human reads in especified database
*/


 process Otu_assingment {
     input:
        path file1
        path file2
        val DB // Val or path, to try both
    publishDir  "${params.otuput_dir}", mode: 'copy' // Check if it not needed
    output:
        file "*.taxonomy.txt"
        file "*.output.txt"
    script:
        def prefix = file1.toString().replaceFirst(".R1\\.fq\\.gz\$", "")
        def kraken_database = "${DB}"
        def entry_kraken = "-paired ${file1} ${file2}"
        """
            # Math with the human chromosome
                kraken2 -db ${kraken_database} --gzip-compressed  \\
                --output ${prefix}.output.txt \\
                --report ${prefix}.taxonomy.txt \\
                --threads 24 --use-mpa-style \\
                $entry_kraken
        """
 }

/*
* Workflow (Complete proces)
*/
workflow {
      sequences = [file(params.fq1), file(params.fq2)]
    println "Performing Quality control and trimming from $sequences" 

    // Run the BBduk process
    Output_bbduk = BBduk(sequences[0], sequences[1])
    
    // Check the human database and create the database variable
    println "The Human Database selected is $params.db_human" 
    Databases = [file(params.db_human), file(params.db_gut)]
    
    // The outputs of BBduk are automatically connected to DNA_clean
    Output_bowtie = DNA_clean(Output_bbduk[0], Output_bbduk[1], Databases[0])

    // Check the gut microbiota database
    println "The Microbial Database selected is $params.db_gut" 
    println "The output folder selected is $params.otuput_dir"

    // The outputs of DNA_clean are automatically connected to Kraken
    Otu_assingment(Output_bowtie[0], Output_bowtie[1], Databases[1])
}
