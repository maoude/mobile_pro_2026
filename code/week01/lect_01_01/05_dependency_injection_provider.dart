// Source: 002_lect_01_01.tex, section 2.2 OOP in Dart - Dependency Injection in Flutter (Provider)
// Flutter + package:provider. HttpApiService, SharedPrefsCacheService and HomeScreen are not defined in the lecture.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class ApiService {
  Future<List<User>> getUsers();
}

abstract class CacheService {
  Future<void> store(String key, dynamic data);
  Future<T?> retrieve<T>(String key);
}

class UserRepository {
  final ApiService api;
  final CacheService cache;
  const UserRepository(this.api, this.cache);

  Future<List<User>> getUsers({bool forceRefresh = false}) async {
    const key = 'users';
    if (!forceRefresh) {
      final cached = await cache.retrieve<List<User>>(key);
      if (cached != null) return cached;
    }
    final users = await api.getUsers();
    await cache.store(key, users);
    return users;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiService>(create: (_) => HttpApiService()),
        Provider<CacheService>(create: (_) => SharedPrefsCacheService()),
        ProxyProvider2<ApiService, CacheService, UserRepository>(
          update: (_, api, cache, __) => UserRepository(api, cache),
        ),
      ],
      child: const MaterialApp(home: HomeScreen()),
    );
  }
}
