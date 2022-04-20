FROM "nvcr.io/nvidia/cuda:11.6.2-base-ubuntu20.04"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"
ARG DEBIAN_FRONTEND=noninteractive

# virtual desktop
ENV SYNTH_HOME=/home/synth
ENV SYNTH_SCRIPTS=$SYNTH_HOME/Scripts
ENV SYNTH_LOGS=$SYNTH_HOME/Logs
ENV SYNTH_PROJECTS=$SYNTH_HOME/Projects
ENV SYNTH_NOTEBOOKS=$SYNTH_HOME/Notebooks

# set up 'synth' account
COPY docker-scripts/synth-user.sh /
RUN /synth-user.sh > /synth-user.log 2>&1

# enable passwordless sudo for 'synth'
COPY docker-scripts/passwordless-sudo /etc/sudoers.d/

# make virtual desktop
RUN mkdir --parents \
  $SYNTH_SCRIPTS \
  $SYNTH_LOGS \
  $SYNTH_NOTEBOOKS \
  $SYNTH_PROJECTS \
  && chown -R synth:synth $SYNTH_HOME

USER synth
WORKDIR $SYNTH_HOME
CMD [ "/bin/bash" ]

# Installing Linux dependencies
COPY --chown=synth:synth Home/Scripts/linux-dependencies.sh $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/linux-dependencies.sh > $SYNTH_LOGS/linux-dependencies.log 2>&1

# Installing Mambaforge
COPY --chown=synth:synth Home/Scripts/mambaforge.sh $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/mambaforge.sh > $SYNTH_LOGS/mambaforge.log 2>&1

# Creating fresh mamba environment 'r-reticulate'
## Python 3.9 is the newest supported by PyTorch and torchaudio
ENV PYTHON_VERSION="3.9"
COPY --chown=synth:synth Home/Scripts/r-reticulate* $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/r-reticulate.sh > $SYNTH_LOGS/r-reticulate.log 2>&1
RUN $SYNTH_SCRIPTS/r-reticulate-test.sh

# Installing cuSignal demo notebooks
COPY --chown=synth:synth Home/Scripts/cusignal-notebooks.sh $SYNTH_SCRIPTS/

# Installing R developer tools
COPY --chown=synth:synth Home/Scripts/*devtools* $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/R-devtools.sh > $SYNTH_LOGS/R-devtools.log 2>&1

# Installing R sound packages
COPY --chown=synth:synth Home/Scripts/*sound* $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/R-sound.sh > $SYNTH_LOGS/R-sound.log 2>&1
RUN /usr/bin/time $SYNTH_SCRIPTS/cusignal-notebooks.sh > $SYNTH_LOGS/cusignal-notebooks.log 2>&1

# Installing JupyterLab
COPY --chown=synth:synth Home/Scripts/jupyterlab.sh $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/jupyterlab.sh > $SYNTH_LOGS/jupyterlab.log 2>&1

# Installing home directory scripts
COPY --chown=synth:synth \
  Home/bash_aliases \
  Home/edit-me-then-run-4-git-config.sh \
  Home/set-vim-background.sh \
  Home/start-jupyter-lab.sh \
  $SYNTH_HOME/
RUN cat $SYNTH_HOME/bash_aliases >> $SYNTH_HOME/.bash_aliases

# Finished!
