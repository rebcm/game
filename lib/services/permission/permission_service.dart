import 'package:permission_handler/permission_handler.dart';

abstract class PermissionService {
  Future<PermissionStatus> requestPermission();
}

class PermissionServiceImpl implements PermissionService {
  @override
  Future<PermissionStatus> requestPermission() async {
    return await Permission.microphone.request();
  }
}

class PermissionWidget extends StatefulWidget {
  final PermissionService permissionService;

  const PermissionWidget({Key? key, required this.permissionService}) : super(key: key);

  @override
  State<PermissionWidget> createState() => _PermissionWidgetState();
}

class _PermissionWidgetState extends State<PermissionWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.permissionService.requestPermission(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == PermissionStatus.permanentlyDenied) {
            return const Text('Permissão negada permanentemente');
          } else if (snapshot.data == PermissionStatus.restricted) {
            return const Text('Dispositivo não possui hardware de microfone');
          } else if (snapshot.data == PermissionStatus.denied) {
            return const Text('Permissão revogada');
          }
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
