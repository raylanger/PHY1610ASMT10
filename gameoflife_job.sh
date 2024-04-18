#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --time=1:00:00
#SBATCH --mail-type=FAIL
#SBATCH --partition=debug

module load TeachEnv/2022a gcc/13.2.0 rarray/2.7.0 catch2

#Define output file
OUTPUT_FILE="output.txt"
TMP_FILE="tmp.txt"
#Ensure output file blank
> $OUTPUT_FILE
> $TMP_FILE

echo -e "Threads\tTime" >> $OUTPUT_FILE

#Iterate through number of threads
for ((thread = 1; thread<=16; thread++));
do
    export OMP_NUM_THREADS=$thread
    
    { time (./gameoflife 1000 1000 1000 0.183 1 > /dev/null 2>&1); } 2>> $TMP_FILE

    true_time=$(awk '/real/ {print $2}' $TMP_FILE)

    rm $TMP_FILE

    echo -e "$thread\t$true_time" >> $OUTPUT_FILE
done

                                                        
