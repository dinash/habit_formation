import 'package:get_it/get_it.dart';
import 'package:habit_formation/injection/getit_setup.config.dart';
import 'package:injectable/injectable.dart';

final getId = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => getId.init();