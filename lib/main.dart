import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limitless_code_template/app.dart';
import 'package:limitless_code_template/core/bloc/bloc_observer.dart';
import 'package:limitless_code_template/core/config/di/injectable.dart';
import 'package:limitless_code_template/core/config/flavors/flavors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
  );
  Bloc.observer = MyBlocObserver();
  await configureDependencies();
  runApp(const AppTemplate());
}
