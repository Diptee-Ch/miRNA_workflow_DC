inputfile=$(basename $1)
xpref=${inputfile%.*}
tempdirname="tmp_$xpref"
mkdir $tempdirname || exit 1
qsub -I -N $xpref -o /path_to_file/$tempdirname/stdout.txt -e /path_to_file/$tempdirname/stderr.txt -l select=1:ncpus=20:mem=125gb,walltime=4:00:00
