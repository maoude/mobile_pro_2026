// Source: 002_lect_01_01.tex, section 2.4 Null Safety and Modern Dart - Records, Patterns, and Sealed Classes
// Uses Flutter widgets in buildUI; needs an import of package:flutter/material.dart.

typedef UserInfo = ({String name, int age});
UserInfo mk(String n, int a) => (name: n, age: a);

sealed class LoadState<T> {
  const LoadState();
}

class Loading<T> extends LoadState<T> {
  const Loading();
}

class Success<T> extends LoadState<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends LoadState<T> {
  final String message;
  const Failure(this.message);
}

Widget buildUI<T>(LoadState<T> s) => switch (s) {
  Loading() => const CircularProgressIndicator(),
  Success(data: final d) => Text('$d'),
  Failure(message: final m) => Text('Error: $m'),
};
