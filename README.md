Сделал домашку по воркшопу Tages. Добавил историю пробега и редактирование характеристик машины.

Посмотреть добавленный код можно по коммитам:

https://github.com/DmitryGaimaldinov/my_garage_workshop/commit/ce44ce6366db7440ac33d0cb17f25e207812da12

https://github.com/DmitryGaimaldinov/my_garage_workshop/commit/fde7c806cec2580dc4ebc5b17667cadde5178ab3

Скриншоты:

Список машин

![image](https://github.com/DmitryGaimaldinov/my_garage_workshop/assets/123044629/83ede8f7-e8cd-4207-8e03-91c886537359)

История пробега

![image](https://github.com/DmitryGaimaldinov/my_garage_workshop/assets/123044629/e9773125-9b8c-4ebc-b2fe-f3f6cd6b3714)

Удаление каких-то элеметов из истории пробега

![image](https://github.com/DmitryGaimaldinov/my_garage_workshop/assets/123044629/24f4eefe-54b3-4825-8f8e-c2488a32bd38)

Обновление пробега

![image](https://github.com/DmitryGaimaldinov/my_garage_workshop/assets/123044629/c80984d9-0d66-4974-9ef8-9106e65f9e46)

Редактирование характеристик машины

![image](https://github.com/DmitryGaimaldinov/my_garage_workshop/assets/123044629/c2413e26-fe8c-4127-a17d-0ed84bc2d8f5)

# Мой гараж

Вы готовы погрузиться в мир кроссплатформенной разработки и создать свое первое приложение «Мой гараж»? Наш воркшоп –
это уникальная возможность для всех, кто хочет освоить Flutter, один из самых востребованных и динамично развивающихся
инструментов для создания приложений на рынке.

## Архитектура

Этот проект следует принципам [Google architecture guidelines](https://developer.android.com/jetpack/docs/guide),
основанным на архитектуре [BLoC](https://bloclibrary.dev/#/), придерживаясь ряд идей
относительно [чистой архитектуры](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html), которые
подразумевают разделение слоев проекта на несколько уровней.

Достичь этих идей также помогает использование Dependency Injection с реализацией DI-контейнера при помощи
пакета [get_it](https://pub.dev/packages/get_it) в связке с автоматическим внедрением зависимостей
через [injectable](https://pub.dev/packages/injectable). Все модели проекта основаны на использовании
объектов [equatable](https://pub.dev/packages/equatable).

## Требования к среде разработки

* [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.16.9 и выше)
* [Dart SDK](https://dart.dev/get-dart) (3.2.6 и выше)
* [Android Studio и IntelliJ](https://docs.flutter.dev/tools/android-studio)
  или [Visual Studio Code](https://docs.flutter.dev/tools/vs-code)

## Начало работы

### Шаг 1

Для установки зависимостей проекта переходим в корневую директорию и запускаем команду:

```shell
flutter pub get
```

### Шаг 2

Этот проект зависим от библиотек, которые используют кодогенерацию, поэтому, необходимо запустить следующую
команду для генерации этих файлов:

```shell
dart run build_runner build --delete-conflicting-outputs
dart run drift_dev schema generate drift_schemas/ ./lib/src/internal/infra/schemes --data-classes --companions
```

### Проблемы с кодогенерацией?

Убедитесь, что вы применяете все свои изменения в коде — запуском кодогенерации. Если же что-то пошло не так, то вы
всегда можете удалить сгенерированные файлы следующей командой:

```shell
dart run build_runner clean
```

И перезапустить кодогенерацию, вернувшись к шагу [№2](#шаг-2).

## Полезные ресурсы

* [Flutter](https://flutter.dev/)
* [Effective Dart](https://dart.dev/effective-dart)
