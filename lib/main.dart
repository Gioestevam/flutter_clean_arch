import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'clean_arch_app.dart';
import 'core/dependency_injection/dependency_injection_conf.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  configureDependencies();
  await Firebase.initializeApp();
  runApp(const CleanArchApp());
}
