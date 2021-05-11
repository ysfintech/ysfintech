class Person {
  String id;
  String name;
  String major;
  String field;
  int number;

  Person({this.id, this.name, this.major, this.field, this.number});

  Person.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        major = map['major'],
        field = map['field'],
        number = map['number'];
}
