FROM python:2.7-alpine
MAINTAINER ADI <hello@adicu.com>

RUN apk update && apk upgrade
RUN apk add ruby ruby-irb ruby-rdoc
RUN gem install sass


COPY ./config/requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt

ADD ./ /app
WORKDIR /app

EXPOSE 8181
CMD source /app/config/secrets.prod && \
        gunicorn run:app -b 0.0.0.0:8181
