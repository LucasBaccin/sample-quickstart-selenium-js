FROM node:20

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        wget \
        ca-certificates \
    && wget -q -O /tmp/google-chrome.deb \
        https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt-get install -y /tmp/google-chrome.deb \
    && rm -f /tmp/google-chrome.deb \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home/wdio/

COPY package*.json ./

RUN npm ci

COPY . .

CMD ["npm", "run", "wdio"]