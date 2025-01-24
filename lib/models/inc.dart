import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class Inc {
  Inc({
    required this.id,
    required this.title,
    required this.amount,
    required this.tag,
    required this.income,
  });

  final int id;
  String title;
  double amount;
  int tag;
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
      amount: reader.readDouble(),
      tag: reader.readInt(),
      income: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, Inc obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
    writer.writeDouble(obj.amount);
    writer.writeInt(obj.tag);
    writer.writeBool(obj.income);
  }
}
