import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final purgeTestProvider = Provider((ref) => PurgeTestService());

class PurgeTestService {
  Future<bool> executePurgeTest() async {
    final response = await http.post(Uri.parse('https://example.com/purge_test'));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
