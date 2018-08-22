#!/bin/bash
#PBS -N scUnif
#PBS -l nodes=cu12
#PBS -M 904469382@qq.com
#PBS -l walltime=7200:00:00



data_dir=/home/yuanhao/single_cell/impute_criteria/simulated_data
output_dir=/home/yuanhao/single_cell/impute_criteria/outputs/scUnif
log_dir=/home/yuanhao/single_cell/impute_criteria/outputs/scUnif_log
mkdir -p $output_dir


dataset=$(ls $data_dir | grep -P "dataset.+?dropout\\.mtx")

for ii in $dataset
do
dataset_name=${ii%_dropout.mtx}
python3 /home/yuanhao/single_cell/impute_criteria/imputation_methods/URSM-master_edited/scUnif.py \
	-sc $data_dir"/"$ii \
	-ctype $data_dir"/"$dataset_name"_groups.tsv" \
	-outdir $output_dir \
	--output_prefix $dataset_name \
	-log $log_dir/logging_file.log \
	-burnin 50 \
	-sample 50 \
	-EM_maxiter 50
done

