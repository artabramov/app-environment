FROM python:3.10
RUN apt-get update

# git
RUN mkdir /app
RUN git clone https://github.com/artabramov/app-backend.git /app
WORKDIR /app

# app logs
RUN mkdir /var/log/app
RUN chown -R www-data:root /var/log/app
RUN touch /var/log/app/app.log
RUN chown -R www-data:root /var/log/app/app.log

# celery logs
RUN mkdir /var/log/celery
RUN chown -R www-data:root /var/log/celery
RUN touch /var/log/celery/celery.log
RUN chown -R www-data:root /var/log/celery/celery.log

# apache
RUN apt-get install -y apache2 apache2-dev
COPY ./.htaccess ./
RUN a2enmod rewrite
RUN apt-get clean
COPY ./000-default.conf ./
RUN mv --force ./000-default.conf /etc/apache2/sites-available/000-default.conf

# venv & requirements
RUN python3.10 -m venv ./venv
RUN ./venv/bin/pip3.10 install mod_wsgi
RUN ln -s /app/venv/lib/python3.10/site-packages/mod_wsgi/server/mod_wsgi-*.so /app/venv/lib/python3.10/site-packages/mod_wsgi/server/mod_wsgi.so
RUN ./venv/bin/pip3.10 install Flask==2.0.2
RUN ./venv/bin/pip3.10 install SQLAlchemy==1.4.31
RUN ./venv/bin/pip3.10 install celery==5.2.3
RUN ./venv/bin/pip3.10 install -U "celery[redis]"
RUN ./venv/bin/pip3.10 install Flask-Celery==2.4.3
RUN ./venv/bin/pip3.10 install Flask-SQLAlchemy==2.5.1
RUN ./venv/bin/pip3.10 install mysql-connector-python==8.0.28
RUN ./venv/bin/pip3.10 install marshmallow==3.15.0
RUN ./venv/bin/pip3.10 install marshmallow-enum==1.5.1
#RUN ./venv/bin/pip3.10 install flask-marshmallow==0.14.0
RUN ./venv/bin/pip3.10 install Flask-Caching==1.10.1

# apache
EXPOSE 80
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
