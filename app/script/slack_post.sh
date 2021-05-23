#!/bin/bash

. /data/.env

function slack_post() {
  local message=${1}
  JSON=$(cat <<EOF
{
    "username": "${SLACK_BOT_NAME}",
    "channel": "${SLACK_CHANNEL}",
    "attachments": [
        {
            "pretext": "<!channel> \\n${message}",
            "fallback": "${message}"
         }
    ]
}
EOF
  )

  curl -i -H "Content-type: application/json" -s -S -X POST -d "${JSON}" "${SLACK_WEBHOOK_URL}"  > /dev/null 2>&1
}


curl -s -o result.html https://item.rakuten.co.jp/jiggys-shop/r-2-012/

mv result.html /data/
sed -i 's/EUC-JP/UTF-8/'  /data/result.html


RET=$(node /script/app2.js)


if [ "${RET}" = "undefined" ]; then
  MESSAGE="ページが取得できませんでした"

  slack_post "${MESSAGE}"
fi

if [ "${RET}" = "undefined" ] && [ "${RET}" != "×" ]; then
  MESSAGE="在庫が復活しました https://item.rakuten.co.jp/jiggys-shop/r-2-012/"

  slack_post "${MESSAGE}"
fi
