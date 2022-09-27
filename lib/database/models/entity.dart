abstract class Entity {
  
  Map<String, dynamic> get criacao => {'criacao': DateTime.now()};

  Map<String, dynamic> toMap();


}