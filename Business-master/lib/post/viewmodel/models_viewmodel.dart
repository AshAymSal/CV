import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Posts
final modelPostIdProvider = StateProvider<int?>((ref) => 0);
final modelPostTypeProvider = StateProvider<String?>((ref) => '');

/// Comments
final modelCommentsTypeProvider = StateProvider<String?>((ref) => '');
final postIdProvider = StateProvider<int?>((ref) => 0);
final postIndexProvider = StateProvider<int?>((ref) => 0);
