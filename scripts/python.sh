# install conda
if [ ! -d $CONDA_HOME ]; then
    curl -sS -o /tmp/conda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash /tmp/conda.sh -b -p $CONDA_HOME
    $CONDA_HOME/bin/conda install -yq python==$PYTHON_VERSION
    rm -rf /tmp/conda.sh
fi
grep -q -F "export CONDA_HOME=$CONDA_HOME" $USER_HOME/.profile || echo "export CONDA_HOME=$CONDA_HOME" >> $USER_HOME/.profile
grep -q -F 'export PATH=$CONDA_HOME/bin:$PATH' $USER_HOME/.profile || echo 'export PATH=$CONDA_HOME/bin:$PATH' >> $USER_HOME/.profile
mkdir -p $USER_HOME/.pip
mkdir -p /root/.pip
echo '[global]' | tee $USER_HOME/.pip/pip.conf /root/.pip/pip.conf
echo 'trusted-host = mirrors.aliyun.com' | tee --append $USER_HOME/.pip/pip.conf /root/.pip/pip.conf
echo 'index-url = https://mirrors.aliyun.com/pypi/simple' | tee --append $USER_HOME/.pip/pip.conf /root/.pip/pip.conf
chown -R vagrant: $USER_HOME/.pip
$CONDA_HOME/bin/pip install --no-cache-dir --default-timeout=120 ipython glances mycli tqdm pymysql mysqlclient fabric argparse pyyaml
chown -R vagrant: $CONDA_HOME
