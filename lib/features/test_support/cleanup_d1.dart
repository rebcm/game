import 'package:d1/d1.dart';

Future<void> cleanupD1() async {
  final d1 = D1.instance;
  await d1.execute('DELETE FROM table_name WHERE condition = true');
}
