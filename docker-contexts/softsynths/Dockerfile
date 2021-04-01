FROM "docker.io/algocompsynth/base"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

# set up 'synth' account
COPY synth-user.sh $SCRIPTS/
RUN $SCRIPTS/synth-user.sh

# enable passwordless sudo for 'synth'
COPY passwordless-sudo /etc/sudoers.d/

ENV SYNTH_HOME=/home/synth
COPY --chown=synth:synth Desktop $SYNTH_HOME/Desktop
COPY --chown=synth:synth Music $SYNTH_HOME/Music
COPY --chown=synth:synth Projects $SYNTH_HOME/Projects
COPY --chown=synth:synth Scripts $SYNTH_HOME/Scripts
COPY --chown=synth:synth Logfiles $SYNTH_HOME/Logfiles
RUN echo "set bg=dark" >> $SYNTH_HOME/.vimrc
RUN chown -R synth:synth $SYNTH_HOME

USER synth
WORKDIR $SYNTH_HOME

# Miniforge
RUN $SYNTH_HOME/Scripts/miniforge.sh

# Define the startup command
CMD [ "/bin/bash" ]
