import 'package:flutter/foundation.dart';
import 'package:plataforma_educacional/core/models/identified.dart';

@immutable
class FriendPreview implements Identified {
  const FriendPreview({required this.id, required this.initials, required this.name,
    required this.course, required this.friendsCount});
  @override
  final String id;
  final String initials;
  final String name;
  final String course;
  final int friendsCount;
}
