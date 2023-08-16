
class APIResponse {
  final ReturnStatus status;
  final String? message;
  final dynamic data;

  APIResponse(this.status, this.message, {this.data});
}

enum ReturnStatus { SUCCESS, WARNING, ERROR, LOGOUT }

extension ParseStatusToString on ReturnStatus {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

T statusFromString<T>(Iterable<T> values, String value) {
  return values.firstWhere((type) => type.toString().split(".").last == value);
}

// class EnumFromString<T> {
//   T get(String value) {
//     return (reflectType(T) as ReturnStatus).getField(#values).reflectee.firstWhere((e)=>e.toString().split('.')[1].toUpperCase()==value.toUpperCase());
//   }
// }
//
// dynamic enumFromString(String value, t) {
//   return (reflectType(t) as ClassMirror).getField(#values).reflectee.firstWhere((e)=>e.toString().split('.')[1].toUpperCase()==value.toUpperCase());
// }

class ReturnStatusType {
  late ReturnStatus returnType;

  ReturnStatusType({required this.returnType});

  ReturnStatusType.fromIndex(int index) {
    // Get enum from index
    returnType = ReturnStatus.values[index];
  }

  bool canLend(ReturnStatus type) {
    if (type == returnType) {
      return true;
    }
    return false;
  }

  int get storageTypeIndex {
    return returnType.index;
  }
}
