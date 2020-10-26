import Bio
from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
import time
import sys
import multiprocessing
import os


Sequencefile = sys.argv[1] #will be fasta file
Outputfile = sys.argv[2]


def checkN():
	record_count=0
	n_count=0
	outputhandle = open(Outputfile,'a')
	with open(Sequencefile, "rU") as _Rna:
		for record in SeqIO.parse(_Rna, "fastq"):
			record_count+=1
			if 'N' in str(record.seq):
				n_count+=1
				continue
			SeqIO.write(record,outputhandle,"fastq")

	outputhandle.close()
	print(' TOtal sequences = { ' + str(record_count) + '}')
	print(' TOtal sequences with N = {' + str(n_count) + '}')
	try:
		print(' Percentage of N  = {' + str(n_count/record_count*100) + '}')
	except:
		raise ValueError("not divisible by 0")
	return n_count



if __name__ == '__main__':
	checkN()
