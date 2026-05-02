import 'package:rebcm/services/cloudflare_token_service.dart';
import 'package:rebcm/utils/error_handler.dart';

void main() async {
  try {
    final token = 'your_token_here';
    final cloudflareTokenService = CloudflareTokenService();
    await cloudflareTokenService.handleTokenError(token);
    // Continue with deployment process
    print('Deployment successful');
  } catch (e) {
    ErrorHandler.handleError(e);
  }
}
