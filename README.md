# miRNA_workflow_DC
This workflow was created to process small RNA transcriptome data in Palmetto Cluster at Clemosn University. 
# Requirements
The following requirements are available as open source; correct installation process available at source code itself. 
* FastQC 0.10.1 (Andrews, 2010)
* Trimmomatic-0.38 (Bolger, et al., 2014)
* ncbi-blast-2.9.0 (Camacho, et al., 2009)
* Bowtie-1.2.3 (Langmead, et al., 2009)
* ‘featureCounts’ in Subread-1.6.5 package (Liao, et al., 2014)
* DESeq2-1.24.0 (Love, et al., 2014)
## 1_Temp_file_initiate_cluster.sh
This creates a temporary file for all outputs.
## 2_Trimmomatic.sh
This removes 'N' containing sequences (RemoveSeqWithN.py), adapter trimming, also saves fasta file (convertToFa.py) ready for use in tRNA and rRNA removal.
## 3_Remove_tRNA_rRNA_size_filter.pbs
Removes tRNA and rRNA sequences and selects for 18-25 nucleotide length. Build balst database first using BLASTBD; see source code. 
## 4_Mapping_featurecounts.sh
Maps and count to create a count file. Reference file in .gtf format. 
## 5_Differential_analysis.R
Differential analysis using DESeq2 (modifed form William Poehlman) 

>The workflow was optimized by Diptee Chaulagain and script written by Dewan Chaulagain. This work is part of Diptee Chaulagain's PhD dissertation done in Frugoli Lab, Department of Genetics and Biochemistry, Clemson University. 
