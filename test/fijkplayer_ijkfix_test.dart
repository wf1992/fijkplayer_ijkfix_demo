import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fijkplayer_ijkfix/fijkplayer_ijkfix.dart';

void main() {
  const MethodChannel channel = MethodChannel('fijkplayer_ijkfix');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
  });
}
