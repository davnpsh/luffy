# Base image MUST be based on Debian
FROM 21-bookworm

### DEPENDENCIES FOR PUPPETEER

# Google Chrome installation
RUN apt-get update && apt-get install gnupg wget -y && \
  wget --quiet --output-document=- https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /etc/apt/trusted.gpg.d/google-archive.gpg && \
  sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
  apt-get update && \
  apt-get install google-chrome-stable -y --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*

### APP INSTALLATION

WORKDIR /luffy

COPY . .

RUN npm install

# App port for frontend
EXPOSE 4000

# Start
CMD ["npm", "run", "bundle"]
