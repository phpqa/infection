#!/usr/bin/env sh
set -e

isCommand() {
  for cmd in \
    "self-update" \
    "run"
  do
    if [ -z "${cmd#"$1"}" ]; then
      return 0
    fi
  done

  return 1
}

if [ "$(printf %c "$1")" = '-' ]; then
  set -- /sbin/tini -- php /composer/vendor/bin/infection "$@"
elif [ "$1" = "/composer/vendor/bin/infection" ]; then
  set -- /sbin/tini -- php "$@"
elif [ "$1" = "infection" ]; then
  set -- /sbin/tini -- php /composer/vendor/bin/"$@"
elif isCommand "$1"; then
  set -- /sbin/tini -- php /composer/vendor/bin/infection "$@"
fi

exec "$@"
