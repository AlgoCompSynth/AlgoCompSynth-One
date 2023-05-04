echo ""
echo "Setting versions to install"
export PYTHON_VERSION="3.10"
echo "..PYTHON_VERSION: $PYTHON_VERSION"

echo ""
echo "Defining CMAKE_BUILD_PARALLEL_LEVEL, MAX_JOBS and MAKEFLAGS"
if [ `nproc` -lt "7" ]
then 
  export CMAKE_BUILD_PARALLEL_LEVEL=4
  export MAX_JOBS=4
  export MAKEFLAGS="-j4"
else
  export CMAKE_BUILD_PARALLEL_LEVEL=`nproc`
  export MAX_JOBS=`nproc`
  export MAKEFLAGS="-j$(nproc)"
fi
echo "..CMAKE_BUILD_PARALLEL_LEVEL: $CMAKE_BUILD_PARALLEL_LEVEL"
echo "..MAX_JOBS: $MAX_JOBS"
echo "..MAKEFLAGS: $MAKEFLAGS"

echo ""
echo "Defining virtual desktop"
export SYNTH_SCRIPTS=$SYNTH_HOME/Scripts
export SYNTH_LOGS=$SYNTH_HOME/Logs
export SYNTH_PROJECTS=$SYNTH_HOME/Projects
export SYNTH_NOTEBOOKS=$SYNTH_HOME/Notebooks
export SYNTH_WHEELS=$SYNTH_HOME/Wheels
echo "..SYNTH_SCRIPTS: $SYNTH_SCRIPTS"
echo "..SYNTH_LOGS: $SYNTH_LOGS"
echo "..SYNTH_PROJECTS: $SYNTH_PROJECTS"
echo "..SYNTH_NOTEBOOKS: $SYNTH_NOTEBOOKS"
echo "..SYNTH_WHEELS: $SYNTH_WHEELS"
