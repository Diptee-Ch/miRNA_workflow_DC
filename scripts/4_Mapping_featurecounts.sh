#Mapping
export PATH="/path_to_software/bowtie-1.2.3:$PATH"
bowtie -M 1 -k 1 --best --strata /path_to_file/MtrunA17_Edit_pre_miRNA -f /path_to_file/Input_TRF.fasta -S Output_file.sam --no-unal
#FeatureCounts
export PATH="$PATH:/path_to_file/subread-1.6.5-source/bin" 
featureCounts -a /path_to_file/premiRNA.gtf -t exon -f -O -M -g transcript_id -o Countfile.txt Output_file.sam 
