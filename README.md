# Rim and Morty (Flutter+Bloc)

## Краткое описание

Flutter-приложение для просмотра персонажей, эпизодов и локаций вселенной Rick and Morty. Построено на `flutter_base_kit` по Clean Architecture: доменные сущности изолированы от REST-схемы, репозитории возвращают `PageResult`, Bloc-и каталогов управляют пагинацией и retry.

---

## Стек технологий

| Слой | Технология | Назначение |
|---|---|---|
| Фреймворк | Flutter 3.41.9 (через FVM) | Кроссплатформенный UI |
| Архитектура | flutter_base_kit | Базовые модули, DI, роутинг, темы |
| Состояние | flutter_bloc / Bloc | Управление состоянием экранов |
| Сеть | Dio + Retrofit | HTTP-клиент + типизированные API |
| Модели | Freezed + json_serializable | Иммутабельные модели с сериализацией |
| Хранение | FlutterSecureStorage | Токен fake-login |
| Навигация | AutoRoute | Типизированный декларативный роутинг |

---

## Особенности

- **Fake-login** — экран входа с генерацией токена в Secure Storage, splash-гейт с редиректом.
- **Characters: адаптивный SliverGrid** — 1–6 колонок по ширине экрана (`GridUtils`); Episodes и Locations — списки с той же пагинацией.
- **Пагинация (infinite scroll)** — через `CharactersBloc` / `EpisodesBloc` / `LocationsBloc`.
- **Pinch-to-zoom** — на detail-экранах через `pinch_to_zoom_scrollable`.
- **Боковое меню** — `flutter_drawer_menu` с разделами: Персонажи, Эпизоды, Локации, Выйти.
- **Локализация** — English-only (intl, ARB).
- **API:** `https://alpha.syazy.com:1180/api` (контракт, совместимый с Rick and Morty API; backend линейки — [rim-backend](https://github.com/menovazin/rim-backend)).

---

## Запуск

Требуется **FVM** (Flutter Version Management). Установка и настройка — https://fvm.app/documentation/getting-started/installation.

```bash
fvm use
fvm flutter pub get
fvm flutter run
```

Версия Flutter зафиксирована в `.fvmrc` (3.41.9).

---

## Ссылки

- Хаб: [main.md](./main.md)
- Бэкенд: https://github.com/menovazin/rim-backend