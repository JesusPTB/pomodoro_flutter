import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:quiver/async.dart';

final remainingTimeProvider = StateProvider<Duration>((ref) => Duration.zero);