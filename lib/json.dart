import 'dart:convert';

main(){
List<Foods> food = List<Foods>();
List<Extra> ext = List<Extra>();
ext.add(Extra(id: "1",name: "ketcap"));
ext.add(Extra(id: "2",name: "mayonez"));
food.add(Foods(id: "1",name: "hamburger",extras: ext));

  
List<Foods> foodsFromJson(String str) =>         List<Foods>.from(json.decode(str).map((x) => Foods.fromJson(x)));

String foodsToJson(List<Foods> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

var test = foodsToJson(food);
print(test);
}

class Foods {
    String id;
    String name;
    List<Extra> extras;

    Foods({
        this.id,
        this.name,
        this.extras,
    });

    factory Foods.fromJson(Map<String, dynamic> json) => Foods(
        id: json["id"],
        name: json["name"],
        extras: List<Extra>.from(json["extras"].map((x) => Extra.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "extras": List<dynamic>.from(extras.map((x) => x.toJson())),
    };
}

class Extra {
    String id;
    String name;

    Extra({
        this.id,
        this.name,
    });

    factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
