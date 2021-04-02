class Contact {
  final int id;
  final String name;
  final int accountNumber;

  Contact(
    this.id,
    this.name,
    this.accountNumber,
  );

  Contact.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json["id"],
        accountNumber = json['accountNumber'];

 Map<String, dynamic> toJson() =>
    {
      'name': name,
      'accountNumber': accountNumber,
    };
    
  @override
  String toString() {
    return 'Contact{id: $id, name: $name, accountNumber: $accountNumber}';
  }
}
