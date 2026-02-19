class WishlistItemEntity {
  final String id;
  final String countryName;
  final String countryCode;
  final String flagUrl;
  final DateTime addedAt;

  const WishlistItemEntity({
    required this.id,
    required this.countryName,
    required this.countryCode,
    required this.flagUrl,
    required this.addedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishlistItemEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
