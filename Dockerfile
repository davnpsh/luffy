# Base image
FROM node:21

# Set the working directory in the container
WORKDIR /luffy

# Copy necessary files
COPY . .

# Install dependencies
RUN npm install

# Expose the port on which your app runs
EXPOSE 4000

# Start
CMD ["npm", "run", "bundle"]
