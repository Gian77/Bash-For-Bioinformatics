### EVERY DAY ANACONDA COMMANDS ###

# search for packages
conda search -f constax
conda search -c bioconda constax

# list conda properties
conda info --envs
conda activate genome_work
conda list

# adding channels 
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge

# create environments
conda create --name myenv

# install packages
conda install -c bioconda constax=2.0.15=pyhdfd78af_0
