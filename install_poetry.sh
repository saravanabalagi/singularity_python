# stop on error
set -e

# install poetry
alias python=$(pwd)/python
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -

# replace symlink executable in $HOME/.local/bin
cd $HOME/.local/bin
mv poetry poetry.bak
cat > poetry <<EOF
if [ -z \$SINGULARITY_ENVIRONMENT ]; then
    singularity exec instance://python \$HOME/.local/share/pypoetry/venv/bin/poetry "\$@"
else
    \$HOME/.local/share/pypoetry/venv/bin/poetry "\$@"
fi
EOF
chmod +x poetry

# configure poetry
# alias poetry=$(pwd)/poetry
echo Running "poetry --version"
poetry --version
poetry config virtualenvs.in-project true

# show poetry config
echo "poetry successfully configured with options"
poetry config --list
