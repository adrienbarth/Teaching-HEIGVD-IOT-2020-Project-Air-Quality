FROM python:3

WORKDIR /usr/src/app

COPY ./app /usr/src/app
RUN pip install --no-cache-dir -r requirements.txt

ENV PYTHONUNBUFFERED=y
ENV FLASK_APP=main.py
CMD [ "flask", "run", "--host", "0.0.0.0" ]
