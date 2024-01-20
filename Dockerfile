# Base image (MUST be based on Debian)
FROM 21-bookworm

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
