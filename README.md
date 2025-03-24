# WordPress with SQLite
This is a Docker image based on the official WordPress image with the SQLite Database Integration plugin already installed.
The goal of this image is that you can start it directly without needing an SQL server first.

This image is built automatically every day using the latest versions of WordPress and the latest version of the SQLite Database Integration plugin.

This is not an official image and **should not be run in production** ! It is in a very early testing phase.
If you do use it in production, make sure to backup the database and the files before any updates.

## How to start
To use this image, simply run it like any other Docker image.
```
docker run -d fireghost/wordpress-sqlite
```
Or, for a more useful example:
```
docker run -d --name wordpress-sqlite -v wordpress-sqlite:/var/www/html -p 80:80 fireghost/wordpress-sqlite:6
```

## Environment variables
You can use all the environment variables set by [the official WordPress image.](https://hub.docker.com/_/wordpress)

Additionally, this image adds these environment variables that define the location of the SQLite database file:
- `WORDPRESS_DB_DIR=/var/www/html/wp-content/database/`
- `WORDPRESS_DB_FILE=wordpress.sqlite`

For example, you can use them like this:
```
docker run -d -v my-wordpress-database:/database -e WORDPRESS_DB_DIR=/database fireghost/wordpress-sqlite
```

## Versions
The version combines the version of WordPress and the version of the SQLite Database Integration plugin.
For example, the version *6.7.1-2.1.16* means that it is using the WordPress version "6.7.1" and the SQLite plugin version "2.1.16".
Here are more examples:
- *latest* = latest version of WordPress and latest version of SQLite plugin.
- *6* = WordPress version "6" and the latest SQLite plugin version.
- *6.7-2* = WordPress version "6.7.x" and SQLite plugin version "2.x.x".
- *6.7.1-2.1.16* = WordPress version "6.7.1" and SQLite plugin version "2.1.16".
