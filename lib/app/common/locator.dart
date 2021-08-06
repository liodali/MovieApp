import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'locator.config.dart';

final getIt = GetIt.asNewInstance();

@InjectableInit()
void configureInjection() => $initGetIt(getIt);