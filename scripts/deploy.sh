#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/leriusss/kupala39-site.git"
APP_DIR="/opt/kupalafest39-site"
WEB_ROOT="/var/www/kupalafest39.ru"
BRANCH="main"

if [[ "${EUID}" -ne 0 ]]; then
  echo "Run as root: sudo $0" >&2
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  echo "git is required" >&2
  exit 1
fi

mkdir -p "${APP_DIR}" "${WEB_ROOT}"

if [[ ! -d "${APP_DIR}/.git" ]]; then
  rm -rf "${APP_DIR:?}"/*
  git clone --branch "${BRANCH}" "${REPO_URL}" "${APP_DIR}"
else
  git -C "${APP_DIR}" fetch origin "${BRANCH}"
  git -C "${APP_DIR}" checkout "${BRANCH}"
  git -C "${APP_DIR}" pull --ff-only origin "${BRANCH}"
fi

install -m 0644 "${APP_DIR}/index.html" "${WEB_ROOT}/index.html"

for dir in assets images media; do
  if [[ -d "${APP_DIR}/${dir}" ]]; then
    mkdir -p "${WEB_ROOT}/${dir}"
    cp -a "${APP_DIR}/${dir}/." "${WEB_ROOT}/${dir}/"
  fi
done

chown -R www-data:www-data "${WEB_ROOT}"
find "${WEB_ROOT}" -type d -exec chmod 755 {} \;
find "${WEB_ROOT}" -type f -exec chmod 644 {} \;

nginx -t
systemctl reload nginx

echo "Deployed kupalafest39.ru from $(git -C "${APP_DIR}" rev-parse --short HEAD)"
