FROM adoptopenjdk/openjdk11:alpine

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8
ENV TZ=Europe/Ljubljana

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
    && apk add --no-cache gettext \
    && apk add --no-cache tzdata

# Add scripts
ADD scripts/bootstrap.sh /

# Create directories
RUN mkdir -p ${log_dir} \
    && mkdir -p ${deploy_dir}

WORKDIR ${deploy_dir}
