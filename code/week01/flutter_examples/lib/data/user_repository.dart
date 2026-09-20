// =====================================================================
// Shared data layer: ApiService, CacheService and UserRepository
// (from lecture 1.1, section 2.2 "Dependency Injection")
// =====================================================================
// IDEAS
//   * Dependency Inversion: UserRepository depends on the ABSTRACT classes
//     ApiService and CacheService, not on a concrete network or database.
//   * So the same repository works with a real server in the app and with
//     the fake, in-memory versions below in demos and tests.
//   * The repository asks the cache first and calls the API only on a miss.
//
// The lecture did not define the concrete classes (HttpApiService,
// SharedPrefsCacheService). FakeApiService and InMemoryCacheService are
// simple stand-ins added so the examples run without a server.
//
// This file has no main(); it is imported by examples 05 and 07.
// =====================================================================

import '../models/user.dart';

// ---------------- Abstractions (contracts) ----------------
abstract class ApiService {
  Future<List<User>> getUsers();
}

abstract class CacheService {
  Future<void> store(String key, dynamic data);
  Future<T?> retrieve<T>(String key);
}

// ---------------- Fake implementations for demos and tests ----------------
class FakeApiService implements ApiService {
  /// How many times the "server" was called (used to prove caching works).
  int calls = 0;

  @override
  Future<List<User>> getUsers() async {
    calls++;
    // Pretend the network takes 200 ms.
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return [
      User(id: '1', name: 'Alice', email: 'alice@example.com'),
      User(id: '2', name: 'Bob', email: 'bob@example.com'),
      User(id: '3', name: 'Carol', email: 'carol@example.com'),
    ];
  }
}

class InMemoryCacheService implements CacheService {
  final Map<String, dynamic> _store = {};

  @override
  Future<void> store(String key, dynamic data) async {
    _store[key] = data;
  }

  @override
  Future<T?> retrieve<T>(String key) async {
    final value = _store[key];
    // Return the value only if it really has the requested type.
    return value is T ? value : null;
  }
}

// ---------------- The repository ----------------
class UserRepository {
  final ApiService api;
  final CacheService cache;
  const UserRepository(this.api, this.cache);

  Future<List<User>> getUsers({bool forceRefresh = false}) async {
    const key = 'users';
    if (!forceRefresh) {
      // 1) Try the cache first.
      final cached = await cache.retrieve<List<User>>(key);
      if (cached != null) return cached;
    }
    // 2) Cache miss (or forced refresh): ask the API, then remember it.
    final users = await api.getUsers();
    await cache.store(key, users);
    return users;
  }
}
