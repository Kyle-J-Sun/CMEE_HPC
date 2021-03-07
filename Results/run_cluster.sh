#!/bin/bash
#PBS -l walltime=12:00:00
#PBS -l select=1:ncpus=1:mem=1gb
module load anaconda3/personal
echo "R is about to run "
R --vanilla < /rds/general/user/ks3020/home/neutral_simulation/ks3020_HPC_2020_cluster.R
mv ks3020_result* /rds/general/user/ks3020/home/neutral_simulation/
echo "R has finished running"
# This is a comment at the end of the file
