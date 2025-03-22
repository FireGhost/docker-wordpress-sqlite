ARG FROM_IMAGE_VERSION=latest
FROM wordpress:$FROM_IMAGE_VERSION

ARG SQLITE_DB_INTEGRATION_VERSION

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
      unzip \
      patch \
    ; \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    rm -rf /var/lib/apt/lists/*;

RUN set -ex; \
    curl -o sqlite-database-integration.zip -fL "https://downloads.wordpress.org/plugin/sqlite-database-integration.$SQLITE_DB_INTEGRATION_VERSION.zip"; \
    unzip sqlite-database-integration.zip -d /usr/src/wordpress/wp-content/plugins/; \
    rm sqlite-database-integration.zip; \
    cp /usr/src/wordpress/wp-content/plugins/sqlite-database-integration/db.copy /usr/src/wordpress/wp-content/db.php; \
    sed -i -e 's;{SQLITE_IMPLEMENTATION_FOLDER_PATH};/var/www/html/wp-content/plugins/sqlite-database-integration;g' /usr/src/wordpress/wp-content/db.php; \
    sed -i -e 's;{SQLITE_PLUGIN};sqlite-database-integration/load.php;g' /usr/src/wordpress/wp-content/db.php; \
    chown -R www-data:www-data /usr/src/wordpress/wp-content; \
    chmod -R 1777 /usr/src/wordpress/wp-content;

COPY patches/* /usr/src/patches/
RUN set -ex; \
    patch --ignore-whitespace --binary /usr/local/bin/docker-entrypoint.sh /usr/src/patches/docker-entrypoint.sh.patch; \
    patch --ignore-whitespace --binary /usr/src/wordpress/wp-config-docker.php /usr/src/patches/wp-config-docker.php.patch;
