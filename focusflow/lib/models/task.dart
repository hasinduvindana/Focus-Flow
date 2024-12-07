class Task {
  final int? id;
  final String name;
  final String description;
  final String date;
  final String time;
  final String location;

  Task({this.id, required this.name, required this.description, required this.date, required this.time, required this.location});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'date': date,
      'time': time,
      'location': location,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      date: map['date'],
      time: map['time'],
      location: map['location'],
    );
  }
}
