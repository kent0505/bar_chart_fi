import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class Inc {
  Inc({
    required this.id,
    required this.title,
    // required this.category,
    required this.amount,
    required this.income,
  });

  final int id;
  String title;
  // String category;
  double amount;
  bool income;
}

class IncAdapter extends TypeAdapter<Inc> {
  @override
  final typeId = 0;

  @override
  Inc read(BinaryReader reader) {
    return Inc(
      id: reader.readInt(),
      title: reader.readString(),
      // category: reader.readString(),
      amount: reader.readDouble(),
      income: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, Inc obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
    // writer.writeString(obj.category);
    writer.writeDouble(obj.amount);
    writer.writeBool(obj.income);
  }
}
