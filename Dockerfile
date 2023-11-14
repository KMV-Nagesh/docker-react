# tagging this stage as builder
# here we are installing dependencies and building our application
FROM node:alpine as builder 

WORKDIR '/app'

copy package.json .
RUN npm install
copy . .

RUN npm run build


# npm run install creates build folder and it is copied to /app folder in container
# For serving applicdation we do not require any folder other than this

# usage of from considers as end of previous stage and beginning of new stage
FROM nginx 
copy --from=builder /app/build /usr/share/nginx/html
# copying /app/build from builder(created in previous stage) to /usr/share/nginx/html
# default command from nginx command starts nginx server. No need override existing run command