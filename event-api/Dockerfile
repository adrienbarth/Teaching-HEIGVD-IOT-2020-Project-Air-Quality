FROM python:3

WORKDIR /usr/src/app

COPY ./app /usr/src/app
RUN pip install --no-cache-dir -r requirements.txt

ENV FLASK_APP=main.py
CMD [ "python3", "-u", "main.py" ]
