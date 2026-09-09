import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  final String? routeName;

  const NotFoundScreen({
    super.key,
    this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 44,
        titleSpacing: 4,
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Page Not Found'),
        centerTitle: false,
      ),
      body: Center(
        child: Text(
          routeName != null
              ? 'No route defined for $routeName'
              : 'Page not found',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
