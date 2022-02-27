class Person {
  String name;
  String major;
  String img;
  String field;

  Person({
    required this.name,
    required this.major,
    required this.img,
    required this.field,
  });

  Person.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        major = map['major'],
        img = map['img'],
        field = map['field'];
}
