import 'dart:convert';

class Restaurant {
  final List<RestaurantElement>? restaurants;

  Restaurant({
    this.restaurants,
  });

  factory Restaurant.fromJson(String str) =>
      Restaurant.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Restaurant.fromMap(Map<String, dynamic> json) => Restaurant(
        restaurants: json["restaurants"] == null
            ? []
            : List<RestaurantElement>.from(
                json["restaurants"]!.map((x) => RestaurantElement.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "restaurants": restaurants == null
            ? []
            : List<dynamic>.from(restaurants!.map((x) => x.toMap())),
      };
}

class RestaurantElement {
  final String? id;
  final String? name;
  final String? description;
  final String? pictureId;
  final String? city;
  final double? rating;
  final Menus? menus;

  RestaurantElement({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.menus,
  });

  factory RestaurantElement.fromJson(String str) =>
      RestaurantElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RestaurantElement.fromMap(Map<String, dynamic> json) =>
      RestaurantElement(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
        menus: json["menus"] == null ? null : Menus.fromMap(json["menus"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
        "menus": menus?.toMap(),
      };
}

class Menus {
  final List<Drink>? foods;
  final List<Drink>? drinks;

  Menus({
    this.foods,
    this.drinks,
  });

  factory Menus.fromJson(String str) => Menus.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Menus.fromMap(Map<String, dynamic> json) => Menus(
        foods: json["foods"] == null
            ? []
            : List<Drink>.from(json["foods"]!.map((x) => Drink.fromMap(x))),
        drinks: json["drinks"] == null
            ? []
            : List<Drink>.from(json["drinks"]!.map((x) => Drink.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "foods": foods == null
            ? []
            : List<dynamic>.from(foods!.map((x) => x.toMap())),
        "drinks": drinks == null
            ? []
            : List<dynamic>.from(drinks!.map((x) => x.toMap())),
      };
}

class Drink {
  final String? name;

  Drink({
    this.name,
  });

  factory Drink.fromJson(String str) => Drink.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Drink.fromMap(Map<String, dynamic> json) => Drink(
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
      };
}