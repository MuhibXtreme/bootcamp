class Record {
  int? id;
  String? name;
  String? email;
  String? designation;
  String? phoneNo;

  Record({this.id, this.name, this.email, this.designation, this.phoneNo});

  Record.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    designation = json['designation'];
    phoneNo = json['phone_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['designation'] = this.designation;
    data['phone_no'] = this.phoneNo;
    return data;
  }
}
