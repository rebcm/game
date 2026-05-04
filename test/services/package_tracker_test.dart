import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/package_tracker.dart';

void main() {
  group('PackageTracker', () {
    late PackageTracker tracker;

    setUp(() {
      tracker = PackageTracker();
    });

    test('starts tracking and clears previous ids', () {
      tracker.addPackageId(1);
      tracker.startTracking();
      expect(tracker.packageIds, isEmpty);
      expect(tracker.isTracking, isTrue);
    });

    test('stops tracking', () {
      tracker.startTracking();
      tracker.stopTracking();
      expect(tracker.isTracking, isFalse);
    });

    test('adds package id when tracking', () {
      tracker.startTracking();
      tracker.addPackageId(1);
      expect(tracker.packageIds, contains(1));
    });

    test('does not add package id when not tracking', () {
      tracker.addPackageId(1);
      expect(tracker.packageIds, isEmpty);
    });

    test('returns tracked package ids', () {
      tracker.startTracking();
      tracker.addPackageId(1);
      tracker.addPackageId(2);
      expect(tracker.getTrackedPackageIds(), [1, 2]);
    });
  });
}
