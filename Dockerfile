FROM ubuntu:18.04

ENV SCREEPS_VER 3.1.7
ENV PORT 21025
ENV CLI_PORT 21026
ENV WORKDIR /opt/screeps

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

RUN mkdir -p /opt/screeps
RUN apt-get update -y && apt-get install -y curl gnupg build-essential

# install nodejs 8
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

EXPOSE ${PORT}
EXPOSE ${CLI_PORT}

ENTRYPOINT ["/entrypoint.sh"]
CMD ["start"]
