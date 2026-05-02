import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passdriver/features/retry_logic/providers/retry_logic_provider.dart';

void main() {
  test('RetryLogicNotifier makes request with retry', () async {
    final container = ProviderContainer();
    final notifier = container.read(retryLogicProvider.notifier);
    await notifier.makeRequest();
    final state = container.read(retryLogicProvider);
    expect(state.attempts, greaterThan(0));
  });
}
