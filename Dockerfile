FROM python:3.9-slim-buster

ENV PYTHONUNBUFFERED=1 \
    PYTHONPATH=/app/ \
    PATH=/app/.local/bin:$PATH \
    PORT=8000

EXPOSE $PORT

# add a non-privileged user for installing and running the application
# don't use --create-home option to prevent populating with skeleton files
RUN mkdir /app && \
    chown 10001:10001 /app && \
    groupadd --gid 10001 app && \
    useradd --no-create-home --uid 10001 --gid 10001 --home-dir /app app

# install packages for pyscopg2 and clean apt caches afterwards
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-transport-https build-essential libpq-dev && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY . /app
RUN chown -R 10001:10001 /app

USER 10001
WORKDIR /app

RUN python -m pip install --upgrade pip && \
    pip install --user -r requirements.txt

ENTRYPOINT ["/app/bin/docker-entrypoint.sh"]
CMD ["web-dev"]
