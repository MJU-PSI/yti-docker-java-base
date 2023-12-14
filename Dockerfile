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
    && apk add --no-cache tzdata \
    && apk add --no-cache ca-certificates

# Add scripts
ADD scripts/bootstrap.sh /
RUN chmod +x /bootstrap.sh

# Create directories
RUN mkdir -p ${log_dir} \
    && mkdir -p ${deploy_dir}

# Download the certificate and place it in the trusted certificate directory
RUN wget -O /usr/local/share/ca-certificates/sigov-ca2.xcert.pem https://www.si-trust.gov.si/assets/si-trust-root/povezovalni-podrejeni/sigovca-2/sigov-ca2.xcert.pem
RUN wget -O /usr/local/share/ca-certificates/si-trust-root.pem https://www.si-trust.gov.si/assets/si-trust-root/korensko-potrdilo/si-trust-root.pem

# Update the certificate store
RUN update-ca-certificates

WORKDIR ${deploy_dir}
