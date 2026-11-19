enum UserRole { resident, manager }

class User {
  final String id;
  final String name;
  final UserRole role;

  new({required this.id, required this.name, required this.role});

  
}
