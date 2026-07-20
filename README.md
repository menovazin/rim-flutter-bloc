# RIM (Flutter+Bloc)

## Краткое описание

Flutter-приложение для просмотра персонажей, эпизодов и локаций вселенной Rick and Morty. Построено на `flutter_base_kit` по Clean Architecture: доменные сущности изолированы от REST-схемы, репозитории возвращают `PageResult`, Bloc-и каталогов управляют пагинацией и retry.

В UI используются две мои open-source библиотеки: [flutter_drawer_menu](https://pub.dev/packages/flutter_drawer_menu) — боковое меню, которое открывается свайпом из основного контента, с параллаксом, вложенным скроллом и tablet mode; и [pinch_to_zoom_scrollable](https://pub.dev/packages/pinch_to_zoom_scrollable) — увеличение картинки щипком, которое не проигрывает ScrollView и после отпускания возвращает изображение к исходному размеру.

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
| UI-пакеты | flutter_drawer_menu, pinch_to_zoom_scrollable | Drawer и pinch-zoom |

---

## Особенности

- **Fake-login** — экран входа с генерацией токена в Secure Storage, splash-гейт с редиректом.
- **Characters: адаптивный grid** — 1–6 колонок по ширине экрана (`GridUtils`); Episodes и Locations — списки с той же пагинацией.
- **Пагинация (infinite scroll)** — через `CharactersBloc` / `EpisodesBloc` / `LocationsBloc`.
- **Pinch-to-zoom** — detail-экраны через `pinch_to_zoom_scrollable`.
- **Боковое меню** — `flutter_drawer_menu`: Персонажи, Эпизоды, Локации, Выйти.
- **Тема** — light / dark / system (persist).
- **Локализация** — English-only (intl, ARB).

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

- Хаб: https://github.com/menovazin/rim-main
- Бэкенд: https://github.com/menovazin/rim-backend
