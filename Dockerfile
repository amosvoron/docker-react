# ----------------------------
# MULTI-STEP DOCKER FILE
# ----------------------------

# build phase
#    We'll refer to node:alpine phase as "builder"
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# run phase
FROM nginx
# copy results from builder phase into this container
COPY --from=builder /app/build /usr/share/nginx/html

# Since default command of the nginx container is to "start nginx"
# we don't need to write
# CMD ["start", "nginx"]
