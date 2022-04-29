ARG ARG_BASE_IMAGE
FROM $ARG_BASE_IMAGE
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"
ARG DEBIAN_FRONTEND=noninteractive

# collect envars
ARG ARG_BASE_IMAGE
ARG ARG_PYTHON_VERSION
ARG ARG_PYTORCH_WHEEL_URL
ARG ARG_PYTORCH_WHEEL_FILE
ARG ARG_TORCHAUDIO_VERSION
ENV BASE_IMAGE=$ARG_BASE_IMAGE
ENV PYTHON_VERSION=$ARG_PYTHON_VERSION
ENV PYTORCH_WHEEL_URL=$ARG_PYTORCH_WHEEL_URL
ENV PYTORCH_WHEEL_FILE=$ARG_PYTORCH_WHEEL_FILE
ENV TORCHAUDIO_VERSION=$ARG_TORCHAUDIO_VERSION

# virtual desktop
ENV SYNTH_HOME=/home/synth
ENV SYNTH_SCRIPTS=$SYNTH_HOME/Scripts
ENV SYNTH_LOGS=$SYNTH_HOME/Logs
ENV SYNTH_PROJECTS=$SYNTH_HOME/Projects
ENV SYNTH_NOTEBOOKS=$SYNTH_HOME/Notebooks
ENV SYNTH_WHEELS=$SYNTH_HOME/Wheels

# set up 'synth' account
COPY docker-scripts/synth-user.sh /
RUN /synth-user.sh > /synth-user.log 2>&1

# enable passwordless sudo for 'synth'
COPY docker-scripts/passwordless-sudo /etc/sudoers.d/

# make virtual desktop
RUN mkdir --parents \
  $SYNTH_SCRIPTS \
  $SYNTH_LOGS \
  $SYNTH_PROJECTS \
  $SYNTH_NOTEBOOKS \
  $SYNTH_WHEELS \
  && chown -R synth:synth $SYNTH_HOME

USER synth
WORKDIR $SYNTH_HOME
CMD [ "/bin/bash" ]

# Installing Mambaforge
COPY --chown=synth:synth Home/Scripts/mambaforge.sh $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/mambaforge.sh > $SYNTH_LOGS/mambaforge.log 2>&1

# Creating fresh mamba environment 'r-reticulate'
COPY --chown=synth:synth Home/Scripts/r-reticulate* $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/r-reticulate.sh > $SYNTH_LOGS/r-reticulate.log 2>&1

# This takes a long time because it is building CuPy from source
COPY --chown=synth:synth Home/Scripts/cupy.sh $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/cupy.sh > $SYNTH_LOGS/cupy.log 2>&1

# Installing PyTorch
COPY --chown=synth:synth Home/Scripts/*pytorch* $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/pytorch.sh > $SYNTH_LOGS/pytorch.log 2>&1
RUN $SYNTH_SCRIPTS/test-pytorch.sh 2>&1 | tee $SYNTH_LOGS/test-pytorch.log

# Installing torchaudio
COPY --chown=synth:synth Home/Scripts/*torchaudio* $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/torchaudio.sh > $SYNTH_LOGS/torchaudio.log 2>&1
RUN $SYNTH_SCRIPTS/test-torchaudio.sh 2>&1 | tee $SYNTH_LOGS/test-torchaudio.log

# Installing cusignal
## newest release
ENV CUSIGNAL_VERSION="22.04.00"
## Don't test by default
ENV CUSIGNAL_TEST="0"
COPY --chown=synth:synth Home/Scripts/cusignal.sh $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/cusignal.sh > $SYNTH_LOGS/cusignal.log 2>&1
# save test notebooks for smaller Jetsons
COPY --chown=synth:synth Home/Scripts/E2E* $SYNTH_NOTEBOOKS/

# Saving cached wheels
COPY --chown=synth:synth Home/Scripts/save-cached-wheels.sh $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/save-cached-wheels.sh > $SYNTH_LOGS/save-cached-wheels.log 2>&1

# Installing home directory scripts
COPY --chown=synth:synth \
  Home/bash_aliases \
  Home/edit-me-then-run-4-git-config.sh \
  Home/set-vim-background.sh \
  Home/start-jupyter-lab.sh \
  $SYNTH_HOME/
RUN cat $SYNTH_HOME/bash_aliases >> $SYNTH_HOME/.bash_aliases

# Finished!
