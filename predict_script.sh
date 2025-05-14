#! /bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --partition=gpu
#SBATCH --mem=100GB
#SBATCH --cpus-per-task=16
#SBATCH --gpus-per-task=a100:1
#SBATCH --time=14-00:00:00
#SBATCH --output=%x.%j.out
#SBATCH --account=yonghui.wu
#SBATCH --qos=yonghui.wu

DATASET=${1:-""}
testB_image_folder=${2:-""}
result_dir=${3:-""}

module load conda
conda activate retfound

python main.py --phase test --device cuda --dataset $DATASET --batch_size 16 --img_ch 1 --seg_classes 9 --seg_visual_factor 30 --adv_weight 1 --cycle_weight 10 --identity_weight 10 --cam_weight 1000 --seg_weight 1000 --aug_options_file aug_options.json --add_seg_link 1  --no_gan 1 --result_dir $result_dir --iteration 3000 --testB_folder $testB_image_folder