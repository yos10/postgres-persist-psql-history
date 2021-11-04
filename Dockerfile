FROM --platform=linux/x86_64 postgres:12

RUN apt-get update && apt-get install -y curl less --no-install-recommends
RUN locale-gen ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP
ENV LANG ja_JP.UTF-8
ENV TZ Asia/Tokyo

ARG USERNAME=postgres

RUN SNIPPET="\set HISTFILE /commandhistory/.psql_history- :DBNAME" \
    && touch /var/lib/postgresql/.psqlrc \
    && mkdir /commandhistory \
    && chown -R $USERNAME /commandhistory \
    && echo $SNIPPET >> "/var/lib/postgresql/.psqlrc"

USER $USERNAME
