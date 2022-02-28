class Service {
  final int id;
  final String name;
  final String imageUrl;
  final String? description;
  final int status;

  Service({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.description,
    required this.status,
  });
}
