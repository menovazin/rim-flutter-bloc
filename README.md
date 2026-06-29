# RIM — Rick and Morty Explorer

Flutter-приложение для просмотра персонажей, эпизодов и локаций вселенной Rick and Morty через публичный REST API.

---

## Как создавался проект (пошагово)

Проект создавался через AI-ассистированный workflow с использованием **OpenSpec**, **Skills** и **flutter_base_kit**.

### Шаг 1. Инициализация инструментов

```bash
# OpenSpec — управление спецификациями и задачами
npm install -g @fission-ai/openspec@latest
openspec init

# Skills — AI-скиллы для инженерной работы
npx skills@latest add mattpocock/skills -y
cp -af .agents/. .skills/ && rm -rf .agents
```

### Шаг 2. Создание базового проекта через flutter_base_kit

```bash
# FVM — фиксируем версию Flutter
# .fvmrc → { "flutter": "3.41.9" }

# Установка и запуск flutter_base_kit
dart pub global activate flutter_base_kit
flutter_base_kit create . --template app

# Скачиваем архитектурные ссылки для справки
mkdir -p arch-refs
cd arch-refs && git clone https://github.com/Okladnoj/flutter_base_kit.git
cd flutter_base_kit && rm -rf .git
```

`flutter_base_kit` генерирует каркас: структуру `lib/`, DI, роутинг, темы, локализацию, базовые сервисы.

### Шаг 3. Формулирование идеи проекта

Через **Perplexity** + скилл `domain-modeling`:
- Прогреть идею приложения для proposal и openspec/config.yaml
- Учесть использование FVM
- Описать архитектуру на базе `flutter_base_kit`
- Определить обязательные пакеты: `flutter_drawer_menu`, `pinch_to_zoom_scrollable`, `flutter_secure_storage`

### Шаг 4. Создание задач через OpenSpec (`/opsx:propose`)

```bash
openspec propose "Flutter-приложение. Rick and Morty REST API. Строгая архитектура на flutter_base_kit. Обязательные пакеты: flutter_drawer_menu, pinch_to_zoom_scrollable, flutter_secure_storage. Экраны: 1. Логин-заглушка (токен в Secure Storage). 2. Главный экран: адаптивный SliverGrid, левое меню (flutter_drawer_menu). Пагинация (infinite scroll). Ошибки сети — заглушкой внутри Grid. 3. Детали: pinch_to_zoom_scrollable, данные из списка без доп. запросов. Разлогин стирает Secure Storage."
```

OpenSpec генерирует:
- `proposal.md` — обоснование (Why), изменения (What), влияние (Impact)
- `design.md` — архитектурные решения, альтернативы, trade-offs
- `tasks.md` — чеклист из ~40 задач по 8 секциям
- `specs/` — 6 спецификаций: `rest-data-layer`, `fake-login`, `main-navigation`, `characters-catalog`, `episodes-catalog`, `locations-catalog`

### Шаг 5. Дизайн-референсы

Через **Lovable** (AI-генератор UI) по `design.md`:
- Получить код и скриншоты
- Положить в `design-refs/` для визуальных reference (отступы, цвета, радиусы)

### Шаг 6. Реализация по спекам

Каждая спецификация реализуется последовательно:

| # | Спецификация | Что делает |
|---|-------------|-----------|
| 1 | `rest-data-layer` | Dio-клиент, API-интерфейсы (Retrofit), репозитории, мапперы, доменные сущности |
| 2 | `fake-login` | Экран логина, TokenService (Secure Storage), Splash-гейт с редиректом |
| 3 | `main-navigation` | Shell-страница, flutter_drawer_menu, AutoTabsRouter, сохранение скролла |
| 4 | `characters-catalog` | CharactersCubit (пагинация), SliverGrid, карточки, Detail + pinch-to-zoom |
| 5 | `episodes-catalog` | EpisodesCubit, список эпизодов, Detail |
| 6 | `locations-catalog` | LocationsCubit, список локаций, Detail |

---

## Стек технологий

| Слой | Технология | Назначение |
|------|-----------|------------|
| Фреймворк | Flutter 3.41.9 (FVM) | Кроссплатформенный UI |
| Архитектура | flutter_base_kit | Базовые модули, DI, роутинг, темы |
| Состояние | flutter_bloc / Cubit | Управление состоянием экранов |
| DI | GetIt + Injectable | Внедрение зависимостей с кодогенерацией |
| Навигация | AutoRoute | Декларативный роутинг с типизированными аргументами |
| Сеть | Dio + Retrofit | HTTP-клиент + типизированные API-интерфейсы |
| Модели | Freezed + json_serializable | Иммутабельные модели с сериализацией |
| Хранение | Hive, SharedPreferences, FlutterSecureStorage | Локальное хранилище, токены, настройки |
| Локализация | intl (ARB) | EN / ES |
| Ассеты | flutter_gen | Типизированный доступ к картинкам, шрифтам, lottie, svg |
| Логирование | talker_flutter | Сетевые и прикладные логи |
| Темы | Material 3 + кастомные расширения | Light / Dark / System |
| Стиль | very_good_analysis + локальные правила | Линтинг |

## Архитектура

Приложение построено по принципам **Clean Architecture** с разделением на слои:

```
lib/
├── api/              ← Сетевой слой (Dio, Retrofit, интерцепторы)
├── config/           ← Константы приложения, настройки Hive
├── core/             ← BLoC/Cubit'ы и глобальные состояния
├── data/             ← Репозитории и мапперы (DTO → Entity)
├── di/               ← DI-контейнер (GetIt + Injectable)
├── domain/           ← Доменные сущности (Entity)
├── gen/              ← Сгенерированные файлы (flutter_gen)
├── l10n/             ← Локализация (ARB-файлы)
├── models/           ← API-модели (Freezed), енумы
├── routes/           ← Роутинг (AutoRoute), observer
├── services/         ← Сервисы (API, storage, logger, other)
├── themes/           ← Темы (light/dark), кастомные расширения
├── ui/               ← UI-слой (страницы, виджеты)
└── utils/            ← Утилиты, расширения, миксины
```

### Поток данных

```
UI (Page) → Cubit → Repository → API (Retrofit/Dio) → Rick & Morty API
                ↑                        ↓
           Domain Entity          JSON Response
                ↑                        ↓
              Mapper ←─────────── API Model (Freezed)
```

## Фичи

- **Splash** — проверка токена в Secure Storage, редирект на Login или Shell
- **Fake Login** — экран авторизации (токен сохраняется в Secure Storage)
- **Main Navigation** — Shell-страница с боковым меню (flutter_drawer_menu)
- **Characters Catalog** — список персонажей с пагинацией (infinite scroll), адаптивный SliverGrid
- **Episodes Catalog** — список эпизодов с пагинацией
- **Locations Catalog** — список локаций с пагинацией
- **Detail Pages** — детальные экраны с pinch-to-zoom (pinch_to_zoom_scrollable)
- **iOS Slide Transitions** — кастомные анимации переходов между экранами
- **Dark / Light Theme** — переключение тем с сохранением выбора
- **Локализация** — EN / ES

## Структура экранов

```
/ (Splash)
├── /login (Login)
└── /shell (Shell — боковое меню)
    ├── /characters (по умолчанию)
    ├── /episodes
    └── /locations

/character-detail  (передаётся Character entity)
/episode-detail    (передаётся Episode entity)
/location-detail   (передаётся Location entity)
```

## Быстрый старт

### Предусловия

- [FVM](https://fvm.app/) установлен глобально
- Xcode (для iOS) / Android Studio (для Android)
- Node.js (для OpenSpec и Skills)

### Установка

```bash
# 1. Клонировать репозиторий
git clone <repo-url> && cd rim

# 2. Установить версию Flutter через FVM
fvm install

# 3. Установить зависимости
fvm flutter pub get

# 4. Запустить кодогенерацию
fvm dart run build_runner build --delete-conflicting-outputs

# 5. Запустить приложение
fvm flutter run
```

### Сборка

```bash
# iOS
fvm flutter build ios

# Android
fvm flutter build apk

# Web
fvm flutter build web
```

## Кодогенерация

Проект использует несколько генераторов. Все сгенерированные файлы закоммичены в репозиторий.

| Генератор | Что генерирует | Конфиг |
|-----------|---------------|--------|
| injectable_generator | di.config.dart | @InjectableInit в di.dart |
| auto_route_generator | router.gr.dart | @AutoRouterConfig в router.dart |
| freezed + json_serializable | *.freezed.dart, *.g.dart | @freezed в моделях |
| retrofit_generator | *_api.g.dart | @RestApi в API-интерфейсах |
| flutter_gen_runner | gen/assets.gen.dart, gen/fonts.gen.dart | pubspec.yaml (assets, fonts) |

```bash
# Разовая генерация
fvm dart run build_runner build --delete-conflicting-outputs

# Вотчер (во время разработки)
fvm dart run build_runner watch --delete-conflicting-outputs
```

## OpenSpec

Спецификации фич хранятся в `openspec/specs/`. Архивированные изменения — в `openspec/changes/archive/`.

```bash
# Инициализация (если ещё не установлен)
npm install -g @fission-ai/openspec@latest
openspec init

# Просмотр спецификаций
ls openspec/specs/
```

## Конвенции

- **Именование файлов**: `snake_case.dart`
- **Именование классов**: `PascalCase`
- **Импорты**: относительные (`prefer_relative_imports: true`)
- **Кавычки**: одинарные (`prefer_single_quotes: true`)
- **Трейлинг-коммы**: preserve (не навязываются)
- **Логика**: никакой бизнес-логики в UI-компонентах
- **FVM**: все команды через `fvm flutter ...` / `fvm dart ...`

## Платформы

- iOS 13+
- Android (minSdk 21)
- Web
- macOS / Linux / Windows (experimental)