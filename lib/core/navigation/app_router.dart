// import 'package:doclib/features/auth/presentation/pages/Auth_secreen.dart';
import 'package:doclib/root_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/app',
  routes: [
    GoRoute(path: '/app', builder: (context, state) => const RootPage()),
    // GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
  ],
  errorBuilder:
      (context, state) => Scaffold(
        body: Center(child: Text('Route not found: ${state.uri.toString()}')),
      ),
);
