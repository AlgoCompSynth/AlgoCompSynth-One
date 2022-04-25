FROM "nvcr.io/nvidia/l4t-base:r34.1"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"
ARG DEBIAN_FRONTEND=noninteractive

# virtual desktop
ENV SYNTH_HOME=/home/synth
ENV SYNTH_SCRIPTS=$SYNTH_HOME/Scripts
ENV SYNTH_LOGS=$SYNTH_HOME/Logs
ENV SYNTH_PROJECTS=$SYNTH_HOME/Projects
ENV SYNTH_NOTEBOOKS=$SYNTH_HOME/Notebooks
ENV SYNTH_WHEELS=$SYNTH_HOME/Wheels
ENV WORKON_HOME=$SYNTH_HOME/.virtualenvs

# set up 'synth' account
COPY docker-scripts/synth-user.sh /
RUN /synth-user.sh > /synth-user.log 2>&1

# enable passwordless sudo for 'synth'
COPY docker-scripts/passwordless-sudo /etc/sudoers.d/

# get the wheels and notebooks from the builder
COPY --from=algocompsynth/wheel-builder:latest $SYNTH_WHEELS $SYNTH_WHEELS
COPY --from=algocompsynth/wheel-builder:latest $SYNTH_NOTEBOOKS $SYNTH_NOTEBOOKS

# make virtual desktop
RUN mkdir --parents \
  $SYNTH_SCRIPTS \
  $SYNTH_LOGS \
  $SYNTH_PROJECTS \
  $WORKON_HOME \
  && chown -R synth:synth $SYNTH_HOME

USER synth
WORKDIR $SYNTH_HOME
CMD [ "/bin/bash" ]

# Installing Linux dependencies
COPY --chown=synth:synth Home/Scripts/linux-dependencies.sh $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/linux-dependencies.sh > $SYNTH_LOGS/linux-dependencies.log 2>&1

# Installing home directory scripts
COPY --chown=synth:synth \
  Home/bash_aliases \
  Home/edit-me-then-run-4-git-config.sh \
  Home/set-vim-background.sh \
  Home/start-jupyter-lab.sh \
  $SYNTH_HOME/
RUN cat $SYNTH_HOME/bash_aliases >> $SYNTH_HOME/.bash_aliases

# Creating fresh Python 3 venv 'r-reticulate'
COPY --chown=synth:synth Home/Scripts/r-reticulate.sh $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/r-reticulate.sh > $SYNTH_LOGS/r-reticulate.log 2>&1

# Testing PyTorch and torchaudio
COPY --chown=synth:synth Home/Scripts/test-pytorch.* $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/test-pytorch.sh 2>&1 | tee $SYNTH_LOGS/test-pytorch.log
COPY --chown=synth:synth Home/Scripts/test-torchaudio.* $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/test-torchaudio.sh 2>&1 | tee $SYNTH_LOGS/test-torchaudio.log

# Finished!
