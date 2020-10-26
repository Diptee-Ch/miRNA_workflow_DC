from Bio import SeqIO
import sys

inputfilename = sys.argv[1]
outputfilename = sys.argv[2]


def FastqtoFasta():
	outputhandle = open(outputfilename,"a")
	with open(inputfilename,"rU") as inputhandle:
		count = SeqIO.convert(inputhandle,"fastq",outputhandle,"fasta")
	

if __name__== "__main__":
	FastqtoFasta()

