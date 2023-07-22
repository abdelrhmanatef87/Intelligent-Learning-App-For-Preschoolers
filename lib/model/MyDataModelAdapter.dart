import 'package:hive/hive.dart';

class MyDataModelAdapter extends TypeAdapter<String> {
  @override
  final int typeId = 0; // Unique identifier for the adapter

  @override
  String read(BinaryReader reader) {
    return reader.readString();
  }

  @override
  void write(BinaryWriter writer, String obj) {
    writer.writeString(obj);
  }
}
