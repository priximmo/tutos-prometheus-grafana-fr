FROM python:3.8-buster

EXPOSE 8080

COPY requirements.txt ./
RUN pip3 install --no-cache-dir -r requirements.txt
RUN mkdir -p /usr/src/app /home/apiuser
RUN useradd -s /bin/bash -d /home/apiuser apiuser
RUN chown -R apiuser /usr/src/ /home/apiuser


USER apiuser

COPY app_exporter.py /usr/src/app
WORKDIR /usr/src/app

CMD python ./app_exporter.py


