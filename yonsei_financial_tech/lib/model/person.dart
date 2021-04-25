class Person {
  String name;
  String major;
  String img;
  String field;

  Person({this.name, this.major, this.img, this.field});

  Person.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        major = map['major'],
        img = map['img'],
        field = map['field'];
}
