import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:my_garage/src/injection.config.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
GetIt configureInjection([Environment? env]) =>
    GetIt.instance.init(environment: env?.name);
