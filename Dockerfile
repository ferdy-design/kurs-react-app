FROM node:18.13.0-bullseye-slim as builder

WORKDIR /app

COPY . .

RUN npm install
RUN npm run build

FROM node:18.13.0-alpine

WORKDIR /app

# RUN addgroup --gid 1005 somegroup \
#   && adduser --uid 1006 --ingroup somegroup --disabled-password --shell /bin/false someuser

COPY --from=builder /app/build build

ENV PORT=8080

USER 1000

CMD [ "npx", "--yes", "serve", "build"]