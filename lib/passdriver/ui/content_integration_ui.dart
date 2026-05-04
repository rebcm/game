import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:game/passdriver/integration_plan/content_integration_plan.dart';

class ContentIntegrationUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ContentIntegrationPlan(),
      child: Consumer<ContentIntegrationPlan>(
        builder: (context, plan, child) {
          return Column(
            children: [
              DropdownButton<String>(
                value: plan.contentSource,
                items: ['local', 'api', 'hardcoded'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  plan.setContentSource(newValue!);
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  switch (plan.contentSource) {
                    case 'api':
                      await plan.injectContentViaAPI();
                      break;
                    case 'local':
                      await plan.loadContentFromLocalFiles();
                      break;
                    case 'hardcoded':
                      await plan.loadHardcodedContent();
                      break;
                  }
                },
                child: Text('Load Content'),
              ),
            ],
          );
        },
      ),
    );
  }
}
