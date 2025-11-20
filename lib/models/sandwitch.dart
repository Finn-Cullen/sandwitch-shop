enum BreadType { white, wheat, wholemeal }

enum SandwichType {
  veggieDelight,
  chickenTeriyaki,
  tunaMelt,
  meatballMarinara,
}

class Sandwich {
  final SandwichType type;
  final bool isFootlong;
  final BreadType breadType;

  Sandwich({
    required this.type,
    required this.isFootlong,
    required this.breadType,
  });

  String get name {
    switch (type) {
      case SandwichType.veggieDelight:
        return 'Veggie Delight';
      case SandwichType.chickenTeriyaki:
        return 'Chicken Teriyaki';
      case SandwichType.tunaMelt:
        return 'Tuna Melt';
      case SandwichType.meatballMarinara:
        return 'Meatball Marinara';
    }
  }

  String get image {
    // Return a local asset path matching the supplied image files in
    // `assets/images/`. Filenames in the project are a bit inconsistent
    // (spaces/underscores), so map explicitly here.
    // Available files (project):
    // - footlong _veggie.jpg
    // - footlong _teryaki.jpg
    // - footlong _meatball.jpg
    // - footlong_tuna.jpg
    // - six_inch _veggie.jpg
    // - six_inch _teryaki.jpg
    // - six_inch _meatball.jpg
    // - six_inch _tuna.jpg

    String imagePath;

    switch (type) {
      case SandwichType.veggieDelight:
        imagePath = isFootlong ? 'assets/images/footlong_veggie.jpg' : 'assets/images/six_inch_veggie.jpg';
        break;
      case SandwichType.chickenTeriyaki:
        imagePath = isFootlong ? 'assets/images/footlong_teriyaki.jpg' : 'assets/images/six_inch_teriyaki.jpg';
        break;
      case SandwichType.tunaMelt:
        imagePath = isFootlong ? 'assets/images/footlong_tuna.jpg' : 'assets/images/six_inch_tuna.jpg';
        break;
      case SandwichType.meatballMarinara:
        imagePath = isFootlong ? 'assets/images/footlong_meatball.jpg' : 'assets/images/six_inch_meatball.jpg';
        break;
    }

    return imagePath;
  }

  // Unit price for this sandwich (depends on type and size).
  num get price {
    // base prices for six-inch
    num base;
    switch (type) {
      case SandwichType.veggieDelight:
        base = 4.0;
        break;
      case SandwichType.chickenTeriyaki:
        base = 5.0;
        break;
      case SandwichType.tunaMelt:
        base = 4.5;
        break;
      case SandwichType.meatballMarinara:
        base = 5.5;
        break;
    }

    // footlongs cost more (approx 1.8x)
    return isFootlong ? (base * 1.8) : base;
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type.name,
      'isFootlong': isFootlong,
      'breadType': breadType.name,
      'name': name,
      'price': price,
      'image': image,
    };
  }
}