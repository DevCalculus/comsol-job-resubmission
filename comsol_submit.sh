#!/bin/bash
#SBATCH --time=06-23:59             # Specify (d-hh:mm)
#SBATCH --account=def-roxa88        # Replace with your account
#SBATCH --mem=0
#SBATCH --cpus-per-task=64
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1

INPUTFILE="your_input_file.mph"
OUTPUTFILE="your_input_file_out.mph"

module load StdEnv/2023
module load comsol/6.3

RECOVERYDIR=$SCRATCH/comsol/recoverydir
mkdir -p $RECOVERYDIR

cp -f ${EBROOTCOMSOL}/bin/glnxa64/comsolbatch.ini comsolbatch.ini
cp -f ${EBROOTCOMSOL}/mli/startup/java.opts java.opts

export I_MPI_COLL_EXTERNAL=0   # Needed on Narval, harmless elsewhere

# === Run COMSOL ===
if [ "$(ls -A $RECOVERYDIR 2>/dev/null)" ]; then
    echo ">> Recovery files found, resuming run..."
    comsol batch -recover -continue \
        -inputfile $INPUTFILE -outputfile $OUTPUTFILE \
        -np $SLURM_CPUS_ON_NODE -nn $SLURM_NNODES \
        -recoverydir $RECOVERYDIR -tmpdir $SLURM_TMPDIR \
        -comsolinifile comsolbatch.ini -alivetime 15
else
    echo ">> No recovery files, starting fresh..."
    comsol batch \
        -inputfile $INPUTFILE -outputfile $OUTPUTFILE \
        -np $SLURM_CPUS_ON_NODE -nn $SLURM_NNODES \
        -recoverydir $RECOVERYDIR -tmpdir $SLURM_TMPDIR \
        -comsolinifile comsolbatch.ini -alivetime 15
fi
