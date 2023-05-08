mixin UnEqualMixin {
  @override
  bool operator ==(Object other) {
    return false;
  }

  @override
  int get hashCode => super.hashCode;
}