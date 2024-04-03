# Ensures Node.js 16.x is installed, which is required for running Gridsome app
FROM python:3.9

# Set working directory
WORKDIR /app

# Add the NodeSource PPA
RUN echo 'Package: nodejs\nPin: origin deb.nodesource.com\nPin-Priority: 600' > /etc/apt/preferences.d/nodesource \
    && curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs

# Install updates
RUN apt-get update

# Install yarn
RUN npm install -g yarn

# Copy requirements.txt to the working directory
COPY requirements.txt .

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy package.json and yarn.lock to the working directory
COPY package.json yarn.lock ./

# Copy the rest of the application code
COPY . ./

# Install dependencies
RUN yarn install

# Expose the port that the app runs on
EXPOSE 8080

# Start the app in development mode
CMD ["yarn", "develop"]
