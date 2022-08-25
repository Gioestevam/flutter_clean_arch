import 'package:flutter/material.dart';

import 'clean_arch_app.dart';
import 'core/dependency_injection/dependency_injection_conf.dart';

void main() {
  configureDependencies();
  runApp(const CleanArchApp());
}
