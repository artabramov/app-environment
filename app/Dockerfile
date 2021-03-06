FROM python:3.10
RUN apt-get update
RUN apt-get install -y ntp
RUN service ntp start

# git
RUN mkdir /app
RUN git clone https://github.com/artabramov/app-backend.git /app
WORKDIR /app

# app logs
RUN mkdir /var/log/app
RUN chown -R www-data:root /var/log/app
RUN touch /var/log/app/app.log
RUN chown -R www-data:root /var/log/app/app.log

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
RUN ./venv/bin/pip3.10 install Flask-SQLAlchemy==2.5.1
RUN ./venv/bin/pip3.10 install psycopg2==2.9.2
RUN ./venv/bin/pip3.10 install marshmallow==3.15.0
RUN ./venv/bin/pip3.10 install marshmallow-enum==1.5.1
RUN ./venv/bin/pip3.10 install redis==4.3.1
RUN ./venv/bin/pip3.10 install Flask-Caching==1.10.1
RUN ./venv/bin/pip3.10 install pyotp==2.6.0
RUN ./venv/bin/pip3.10 install qrcode[pil]==7.3.1
RUN ./venv/bin/pip3.10 install flask-cors==3.0.10

# directories permissions
RUN chmod -R 777 /app/qrcodes
RUN chmod -R 777 /app/images
RUN chmod -R 777 /app/uploads

# frontend
RUN rm -r /var/www/html/*
RUN git clone https://github.com/artabramov/app-frontend.git /var/www/html

# apache
EXPOSE 80
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
