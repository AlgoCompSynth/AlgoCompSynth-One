ARG ARG_BASE_IMAGE
FROM $ARG_BASE_IMAGE
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"
ARG DEBIAN_FRONTEND=noninteractive

# display arguments
ARG ARG_BASE_IMAGE
ENV BASE_IMAGE=$ARG_BASE_IMAGE
RUN echo "BASE_IMAGE=$BASE_IMAGE"

ARG ARG_PYTHON_VERSION
ENV PYTHON_VERSION=$ARG_PYTHON_VERSION
RUN echo "PYTHON_VERSION=$PYTHON_VERSION"

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

# make virtual desktop
RUN mkdir --parents \
  $SYNTH_SCRIPTS \
  $SYNTH_LOGS \
  $SYNTH_NOTEBOOKS \
  $SYNTH_PROJECTS \
  $SYNTH_WHEELS \
  $WORKON_HOME \
  && chown -R synth:synth $SYNTH_HOME

USER synth
WORKDIR $SYNTH_HOME
CMD [ "/bin/bash" ]

# Installing home directory scripts
COPY --chown=synth:synth \
  Home/bash_aliases \
  Home/vimrc \
  $SYNTH_HOME/
RUN cat $SYNTH_HOME/bash_aliases >> $SYNTH_HOME/.bash_aliases
RUN cat $SYNTH_HOME/vimrc >> $SYNTH_HOME/.vimrc

# Installing Linux dependencies
COPY --chown=synth:synth Home/Scripts/linux-dependencies.sh $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/linux-dependencies.sh > $SYNTH_LOGS/linux-dependencies.log 2>&1

# Installing Mambaforge
COPY --chown=synth:synth Home/Scripts/mambaforge.sh $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/mambaforge.sh > $SYNTH_LOGS/mambaforge.log 2>&1

# Installing cusignal and CuPy
## newest release
ENV CUSIGNAL_VERSION="22.04.00"
## Run testing in Docker builds
ENV CUSIGNAL_TEST="1"
COPY --chown=synth:synth Home/Scripts/cusignal* $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/cusignal.sh > $SYNTH_LOGS/cusignal.log 2>&1

# Copying cached wheels
COPY --chown=synth:synth Home/Scripts/copy-cached-wheels.sh $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/copy-cached-wheels.sh > $SYNTH_LOGS/copy-cached-wheels.log 2>&1

# Finished!
