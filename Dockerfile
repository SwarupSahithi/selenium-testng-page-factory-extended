# Use Maven with JDK 8
FROM maven:3.8.7-eclipse-temurin-8 as build


# Install Chrome
RUN apt-get update && apt-get install -y wget gnupg2 curl unzip \
 && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
 && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
 && apt-get update && apt-get install -y google-chrome-stable \
 && rm -rf /var/lib/apt/lists/*

# Set display to avoid Selenium errors
ENV DISPLAY=:99

# Set work directory
WORKDIR /app

# Copy all project files
COPY . .

# Build the project and run tests using headless-chrome profile
RUN mvn clean test -Pheadless-chrome
