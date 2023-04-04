FROM adoptopenjdk/openjdk11:jre-11.0.6_10-alpine@sha256:a9295aa69d9dbbeb123c7d8b72a8bef5f3523f89523b77802a4d7f74f33df6a9

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# Variables
ENV home_dir /data
ENV log_dir ${home_dir}/logs
ENV deploy_dir ${home_dir}/deploy

# Install common tools
RUN set -x \
    && apk update && apk upgrade \
    && apk add --no-cache bash \
    && apk add --no-cache fontconfig \
    && apk add --no-cache ttf-dejavu \
    && apk add --no-cache gettext

# Add scripts
ADD scripts/bootstrap.sh /

# Create directories
RUN mkdir -p ${log_dir} \
    && mkdir -p ${deploy_dir}

WORKDIR ${deploy_dir}
