#! /bin/bash
python /home/ubuntu/mate_marote_web/manage.py runserver 0.0.0.0:8080 &
firefox localhost:8080; killall python;
