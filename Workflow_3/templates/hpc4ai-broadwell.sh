#!/bin/bash
#SBATCH -J visivo-step
#SBATCH -c 36
#SBATCH -p broadwell
#SBATCH -t 06:00:00


source ${HOME}/spack_v0.22/share/spack/setup-env.sh

spack load apptainer@1.1.9%gcc@9.4.0 arch=linux-ubuntu20.04-broadwell

apptainer       \
    exec        \
    --fakeroot  \
    --cleanenv  \
    --contain   \
    --bind ${HOME}:${HOME} \
    --bind ${HOME}/VISIVO/VisIVOCWL/tmp/build:/tmp \
    docker://visivolab/visivoserver:latest \
    sh -c '{{ streamflow_command }}'
