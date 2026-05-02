import Intl.message('package:flutter/material.dart');
import Intl.message('package:cloudflare_pages/cloudflare_pages.dart');

class DeployFeature extends StatefulWidget {
  @override
  _DeployFeatureState createState() => _DeployFeatureState();
}

class _DeployFeatureState extends State<DeployFeature> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Intl.message('Deploy')),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text(Intl.message('Deploy para Cloudflare Pages')),
          onPressed: () {
            // Implementar deploy para Cloudflare Pages
            CloudflarePages.pushToDeploy();
          },
        ),
      ),
    );
  }
}
