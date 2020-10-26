num_threads=28

inputfile=$(basename $1)
xpref=${inputfile%.*}
tempdirname="tmp_$xpref"

module add anaconda3/2.5.0
source activate env

#module load fastqc/0.10.1
#fastqc


tempval="_N.fastq"
removeN_output="/path_to_file/$tempdirname/$xpref$tempval"
python /path_to_file/RemoveSeqWithN.py $1 $removeN_output || exit 1

module add trimmomatic/0.38
module add java/1.8.0

tempval="_T.fastq"
trimmo_output="/path_to_file/$tempdirname/$xpref$tempval"
java -jar /software/trimmomatic/0.38/trimmomatic-0.38.jar SE -threads $num_threads $removeN_output $trimmo_output ILLUMINACLIP:/software/trimmomatic/0.38/adapters/TruSeq3-SE.fa:2:30:10 SLIDINGWINDOW:4:20 LEADING:5 TRAILING:5 MINLEN:10

tempval="_T.fasta"
fasta_file="/path_to_file/$tempdirname/$xpref$tempval"
python /path_to_file/convertToFa.py $trimmo_output $fasta_file

exit
