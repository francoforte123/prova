import 'dart:convert';

import 'package:flutter/foundation.dart';

class Recepi2 {
  String Title;
  String Instructions;
  String Ingredients;
  String Image_Name;
  String Cleaned_Ingredients;
  Recepi2({
    required this.Title,
    required this.Instructions,
    required this.Ingredients,
    required this.Image_Name,
    required this.Cleaned_Ingredients,
  });

  Recepi2 copyWith({
    String? Title,
    String? Instructions,
    String? Ingredients,
    String? Image_Name,
    String? Cleaned_Ingredients,
  }) {
    return Recepi2(
      Title: Title ?? this.Title,
      Instructions: Instructions ?? this.Instructions,
      Ingredients: Ingredients ?? this.Ingredients,
      Image_Name: Image_Name ?? this.Image_Name,
      Cleaned_Ingredients: Cleaned_Ingredients ?? this.Cleaned_Ingredients,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Title': Title,
      'Instructions': Instructions,
      'Ingredients': Ingredients,
      'Image_Name': Image_Name,
      'Cleaned_Ingredients': Cleaned_Ingredients,
    };
  }

  factory Recepi2.fromMap(Map<String, dynamic> map) {
    return Recepi2(
      Title: map['Title'] as String,
      Instructions: map['Instructions'] as String,
      Ingredients: map['Ingredients'] as String,
      Image_Name: map['Image_Name'] as String,
      Cleaned_Ingredients: map['Cleaned_Ingredients'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Recepi2.fromJson(String source) =>
      Recepi2.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Recepi2(Title: $Title, Instructions: $Instructions, Ingredients: $Ingredients, Image_Name: $Image_Name, Cleaned_Ingredients: $Cleaned_Ingredients)';
  }

  @override
  bool operator ==(covariant Recepi2 other) {
    if (identical(this, other)) return true;

    return other.Title == Title &&
        other.Instructions == Instructions &&
        other.Ingredients == Ingredients &&
        other.Image_Name == Image_Name &&
        other.Cleaned_Ingredients == Cleaned_Ingredients;
  }

  @override
  int get hashCode {
    return Title.hashCode ^
    Instructions.hashCode ^
    Ingredients.hashCode ^
    Image_Name.hashCode ^
    Cleaned_Ingredients.hashCode;
  }
}