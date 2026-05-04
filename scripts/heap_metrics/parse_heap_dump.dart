import 'dart:convert';
import 'dart:io';

void main(List<String> args) {
  final file = File(args[0]);
  final json = jsonDecode(file.readAsStringSync());
  // Parse the heap dump JSON and print the results
  print(json['classNames'].length);
}
