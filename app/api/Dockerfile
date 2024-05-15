FROM ubuntu

RUN <<EOF
apt update
apt install -y python3 python3-pip python3.12-venv
EOF

WORKDIR /app

COPY . .

RUN  <<EOF
/bin/bash
python3 -m venv .venv
.venv/bin/python3 -m pip install -r requirements.txt
EOF

CMD .venv/bin/python3 main.py

EXPOSE 8000