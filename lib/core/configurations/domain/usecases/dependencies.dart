import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import '../entities/environment.dart';
import 'dependencies.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init(environment: environment);
