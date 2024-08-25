class MTable {
  int? id;
  String name;
  int? numberOfSeats;
  int? tableStatus;
  String? time;

  MTable(
      {this.id,
      required this.name,
      required this.numberOfSeats,
      required this.tableStatus,
      required this.time});

  // Convert a Product into a Map. The keys must correspond to the column names in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'numberOfSeats': numberOfSeats,
      "tableStatus": tableStatus,
      "time": time
    };
  }

  // Extract a Product object from a Map.
  factory MTable.fromMap(Map<String, dynamic> map) {
    return MTable(
        id: map['id'],
        name: map['name'],
        numberOfSeats: map['numberOfSeats'],
        tableStatus: map['tableStatus'],
        time: map['time']);
  }
}
