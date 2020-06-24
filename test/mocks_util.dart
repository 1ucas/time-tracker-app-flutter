
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:time_tracker_flutter/common/domain/repositories/auth_repository.dart';

class MockAuth extends Mock implements AuthRepository {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}
