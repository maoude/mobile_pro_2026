// Source: 002_lect_01_01.tex, section 2.4 Null Safety and Modern Dart - Null Safety Fundamentals
// Excerpt: ApiClient and User are not defined here.

String nonNull = 'John';
String? maybeNull;

String display(String? name) => name ?? 'Anonymous';
int? len(String? s) => s?.length;

class Service {
  late final ApiClient _client;
  void init(String base) {
    _client = ApiClient(base);
  }

  Future<User> getUser(String id) => _client.fetchUser(id);
}
