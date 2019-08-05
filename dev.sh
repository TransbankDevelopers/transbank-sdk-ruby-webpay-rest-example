#!/usr/bin/env bash
rm -f ${PWD}/.bundled &&
docker-compose run --rm web bundle update &&
make