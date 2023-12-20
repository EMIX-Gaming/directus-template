ARG NODE_VERSION="18"
ARG NODE_ENV="development"

FROM --platform=${BUILDPLATFORM} node:${NODE_VERSION}-alpine as build

WORKDIR /app

COPY package.json package-lock.json /app/
COPY .directus/ /app/.directus
COPY ./extensions/ /app/extensions/

RUN apk --no-cache add python3 build-base \
  	&& ln -sf /usr/bin/python3 /usr/bin/python \
    && npm ci \
    && npm run build \
    && chown node:node /app

FROM --platform=${TARGETPLATFORM} node:${NODE_VERSION}-alpine

LABEL org.opencontainers.image.authors="EMIX Gaming <flx@emixgaming.com>"
LABEL org.opencontainers.image.nodeversion=${NODE_VERSION}
LABEL org.opencontainers.image.revision=${COMMIT_SHA}
LABEL org.opencontainers.image.vendor="EMIX Gaming"

ENV NODE_ENV=${NODE_ENV}

WORKDIR /app

COPY --from=build --chown=node:node /app /app

CMD npx directus bootstrap \
    && npx directus database migrate:latest \
    && npx directus start

EXPOSE 8055
