FROM ubuntu

RUN <<EOF
apt update
apt install -y python3
EOF

WORKDIR /app

COPY . .

CMD python3 -m http.server 8181

EXPOSE 8181