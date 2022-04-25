# stop on error
set -e

# poetry 1.1.7 to 1.1.11 create executables under $HOME/.poetry/bin
# script_path="https://raw.githubusercontent.com/python-poetry/poetry/1.1.11/get-poetry.py"
# curl -sSL $script_path | singularity exec instance://$instance python -
# ln -sf $HOME/.poetry/bin/poetry $HOME/.local/bin/poetry

# install poetry 
# master was 1.1.13 at the time of writing
instance=dev
script_path="https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py"
curl -sSL $script_path | singularity exec instance://$instance python -

# replace symlink executable in $HOME/.local/bin
cd $HOME/.local/bin
mv poetry poetry.bak
cat > poetry <<EOF
instance=dev
if [ -z \$SINGULARITY_ENVIRONMENT ]; then
    singularity exec instance://\$instance \$HOME/.local/share/pypoetry/venv/bin/poetry "\$@"
else
    \$HOME/.local/share/pypoetry/venv/bin/poetry "\$@"
fi
EOF
chmod +x poetry

# configure poetry
echo Running "poetry --version"
poetry --version
poetry config virtualenvs.in-project true

# show poetry config
echo "poetry successfully configured with options"
poetry config --list
