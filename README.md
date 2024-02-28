Сделал домашку по воркшопу Tages. Добавил историю пробега и редактирование характеристик машины.

Посмотреть добавленный код можно в пулреквесте https://github.com/DmitryGaimaldinov/my_garage_workshop/pull/1

Скриншоты:

Список машин

![image](https://github.com/DmitryGaimaldinov/my_garage_workshop/assets/123044629/c9bd66f4-e918-42fc-9d4f-cc18f55c521b)

История пробега

![image](https://github.com/DmitryGaimaldinov/my_garage_workshop/assets/123044629/c94850c9-4023-44ba-acc1-07600ef40a17)


Удаление каких-то элеметов из истории пробега

![image](https://github.com/DmitryGaimaldinov/my_garage_workshop/assets/123044629/a05617e2-25e0-497e-9972-4491bae353c9)


Обновление пробега

![image](https://github.com/DmitryGaimaldinov/my_garage_workshop/assets/123044629/27ba022e-471e-4c4a-aab8-8967983ad834)


Редактирование характеристик машины

![image](https://github.com/DmitryGaimaldinov/my_garage_workshop/assets/123044629/71044d3a-1842-4644-8a7e-1c056845cad0)


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
