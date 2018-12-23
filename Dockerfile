# Dockerfile for latest factorio headless server
FROM ubuntu:18.10

ENV SCREEPS_VER 3.2.0

# default launch options (override these in docker run)
ENV DB /opt/screeps_data/db.json
ENV LOGDIR /opt/screeps_data/logs
ENV MODFILE /opt/screeps_data/mods.json
ENV ASSETDIR /opt/screeps_data/asserts
ENV PORT 21025
ENV HOST 0.0.0.0
ENV PASSWORD ""
ENV CLI_PORT 21026
ENV CLI_HOST 0.0.0.0
ENV RUNNER_THREADS 4
ENV PROCESSORS_CNT 2
ENV STEAM_WEB_API_KEY ""

USER root

RUN mkdir -p /opt/screeps /opt/screeps_data/asserts
RUN apt-get update -y && apt-get install -y curl gnupg build-essential

# install nodejs 8
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

# get screeps
WORKDIR /opt/screeps
RUN npm install screeps@${SCREEPS_VER}
RUN echo "${STEAM_WEB_API_KEY}" | npx screeps init

EXPOSE ${PORT}
EXPOSE ${CLI_PORT}

# CMD ["/bin/bash", "npx", "screeps", "start", \
#     "--db", ${DB}, \
#     "--logdir", ${LOGDIR}, \
#     "--modfile", ${MODFILE}, \
#     "--assetdir", ${ASSETDIR}, \
#     "--port", ${PORT}, \
#     "--host", ${HOST}, \
#     "--password", ${PASSWORD}, \
#     "--cli_port", ${CLI_PORT}, \
#     "--cli_host", ${CLI_HOST}, \
#     "--runner_threads", ${RUNNER_THREADS}, \
#     "--processors_cnt", ${PROCESSORS_CNT}, \
#     #"--steam_api_key", ${STEAM_WEB_API_KEY} \
# ]
CMD npx screeps start \
    #--db ${DB} \
    --logdir ${LOGDIR} \
    #--modfile ${MODFILE} \
    #--assetdir ${ASSETDIR} \
    --port ${PORT} \
    --host ${HOST} \
    --password ${PASSWORD} \
    --cli_host ${CLI_HOST} \
    --cli_port ${CLI_PORT} \
    --runner_threads ${RUNNER_THREADS} \
    --processors_cnt ${PROCESSORS_CNT} \
    --steam_api_key ${STEAM_WEB_API_KEY}