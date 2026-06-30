# kupalafest39.ru

Рабочий пакет для быстрого запуска промо-кампании фестиваля Ивана Купалы в Птичьем Дворе.

## Файлы

`index.html` — статичный лендинг для домена `kupalafest39.ru`.

`social-pack.md` — тексты для VK, Telegram, партнерских посевов, блогеров, stories и Reels.

`AGENTS.md` — рабочие правила проекта для дальнейших Codex-заходов.

`scripts/deploy.sh` — скрипт обновления сайта на VPS.

## Campaign hub

Campaign strategy, content planning, partner outreach, asset notes and reporting live outside this website repository:

`..\marketing-kit`

Keep this repository focused on website implementation and website assets.

## Route / maps policy

The public landing page currently uses Yandex Maps as the only route CTA. Google Maps and 2GIS route buttons are intentionally not used on the public site until their address data is reliable enough for guests.

## Хостинг

План: хранить код на GitHub, а сайт публиковать на внешнем VPS через nginx, рядом с существующими проектами пользователя.

GitHub Pages для этого проекта не используется. Файл `CNAME` не нужен: домен должен вести на VPS через DNS, а nginx должен обслуживать отдельный server block для `kupalafest39.ru`.

Для `kupalafest39.ru` отдельный backend-сервис не нужен: это статичный сайт. Достаточно отдельной директории для файлов сайта, отдельного nginx-конфига и SSL-сертификата.

## Обновление сайта на VPS

После изменений в GitHub зайти на VPS и выполнить:

```bash
bash /opt/kupalafest39-site/scripts/deploy.sh
```

Скрипт подтянет свежую версию из GitHub, обновит публичные файлы, проверит nginx и перезагрузит конфигурацию.

## Что проверить перед следующей публикацией

1. Добавить финальные ссылки на VK-событие и Telegram после подтверждения.
2. Добавить контакт организатора для вопросов гостей после подтверждения.
3. Добавить погодный план и pets policy после подтверждения.
4. Не менять подтвержденные факты без сверки с `..\marketing-kit`.
5. Сохранять Yandex Maps как единственный публичный route CTA, пока Google/2GIS не подтверждены как надежные для точного адреса.

## Минимальная схема запуска на VPS

1. В DNS домена прописать `A`-записи для `kupalafest39.ru` и `www.kupalafest39.ru` на IP VPS.
2. На сервере создать отдельную директорию под сайт.
3. Загрузить туда содержимое репозитория или настроить pull из GitHub.
4. Создать отдельный nginx-конфиг для `kupalafest39.ru`.
5. Проверить HTTP-отдачу.
6. Выпустить SSL через certbot.
7. Проверить `https://kupalafest39.ru` и `https://www.kupalafest39.ru`.
