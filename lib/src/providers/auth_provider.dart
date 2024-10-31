import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth.dart';

final authProvider = ChangeNotifierProvider<Auth>((ref) {
  final auth = Auth();
  auth.init();
  return auth;
});