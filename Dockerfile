#
# LinuxGSM Counter Strike: Global Offensive Dockerfile
#
# https://github.com/GameServerManagers/docker-csgoserver
#

FROM gameservermanagers/linuxgsm:ubuntu-22.04
LABEL maintainer="LinuxGSM <me@danielgibbs.co.uk>"

ENV GAMESERVER csgoserver
ENV SHORTNAME csgo
ENV DISTRO ubuntu-22.04

USER root
## Auto install game server requirements
RUN depshortname=$(curl --connect-timeout 10 -s https://raw.githubusercontent.com/GameServerManagers/LinuxGSM/master/lgsm/data/${DISTRO}.csv |awk -v shortname="${SHORTNAME}" -F, '$1==shortname {$1=""; print $0}') \
  && if [ -n "${depshortname}" ]; then \
  echo "**** Install ${depshortname} ****" \
  && apt-get update \
  && apt-get install -y ${depshortname} \
  && apt-get -y autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*; \
  fi

USER linuxgsm
HEALTHCHECK --interval=1m --timeout=1m --start-period=2m --retries=1 CMD /linuxgsm/*server monitor || exit 1

ENTRYPOINT ["/init"]
CMD [ "./entrypoint.sh" ]
