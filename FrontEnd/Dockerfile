FROM node:18-alpine AS builder

WORKDIR /app

ARG VITE_SUPABASE_URL
ARG VITE_SUPABASE_ANON_KEY
ENV VITE_SUPABASE_URL=$VITE_SUPABASE_URL
ENV VITE_SUPABASE_ANON_KEY=$VITE_SUPABASE_ANON_KEY

# Copy file dependency first to take advantage of cache Docker
COPY package.json package-lock.json ./

# Setup library
RUN npm ci

# ---------------- Build project ----------------

# Copy all source code into
COPY . .

# Build project (folder dist contains static files)
RUN npm run build

# ---------------- Serve project ----------------

FROM nginx:alpine

# Remove default configuration of Nginx (if exists)
RUN rm /etc/nginx/conf.d/default.conf || true
RUN rm -rf /usr/share/nginx/html/*

# Create nginx.conf

# Copy file nginx.conf into conf.d
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy files from builded folder "dist" to web folder
COPY --from=builder /app/dist /usr/share/nginx/html/

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
