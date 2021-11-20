class InstanceManager {
  InstanceManager._();

  static InstanceManager? _instance;

  static InstanceManager get instance {
    _instance ??= InstanceManager._();
    return _instance!;
  }

  final Map<Type, Object> _instances = <Type, Object>{};

  T get<T>() {
    return _instances[T] as T;
  }

  void set<T>(T instance) {
    _instances[T] = instance as Object;
  }
}
