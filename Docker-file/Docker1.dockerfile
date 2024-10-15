## This is a Docker-File used to deploy a static web on Kubernetes

# Pulling an Base Image
FROM ubuntu

# changing current working directory to install necessary software
WORKDIR ~/

# Installing Apache2
RUN apt-get update && apt-get -y install software-properties-common && apt-get -y install git && apt-get install -y --no-install-recomemnds apt-utils
RUN apt-get install -y apache2 

# Enable apache2 mods
RUN a2enmod ssl && a2enmod headers && a2enmod rewrite && service apache2 restart

WORKDIR /var/www/html/

# Rename the default index file
RUN mv index.html index_old.html

# Copy code to container
COPY ./* .

EXPOSE 80

ENTRYPOINT   ["apache2ctl"]

CMD ["-DFOREGROUND"]
