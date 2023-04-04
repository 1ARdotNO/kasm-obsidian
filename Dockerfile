
FROM kasmweb/core-ubuntu-focal:1.12.0
USER root


ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########
RUN curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | sudo -E bash -s install deb-get
RUN deb-get install obsidian

RUN echo "/usr/bin/desktop_ready && Obsidian &" > $STARTUPDIR/custom_startup.sh \
&& chmod +x $STARTUPDIR/custom_startup.sh


######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000