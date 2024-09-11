class PlanetModel {
  String name;
  String mass;
  String radius;
  String gravity;
  String orbitalPeriod;
  bool hasRings;
  String image;
  String position;
  String description;

  PlanetModel({
    required this.name,
    required this.mass,
    required this.radius,
    required this.gravity,
    required this.orbitalPeriod,
    required this.hasRings,
    required this.image,
    required this.position,
    required this.description,
  });

  factory PlanetModel.fromMap({required Map data}) {
    return PlanetModel(
      name: data['name'],
      mass: data['mass'],
      radius: data['radius'],
      gravity: data['gravity'],
      orbitalPeriod: data['orbitalPeriod'],
      hasRings: data['hasRings'],
      image: data['image'],
      position: data['position'],
      description: data['description'],
    );
  }
}
