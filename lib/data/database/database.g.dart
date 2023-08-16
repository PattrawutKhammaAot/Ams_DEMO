// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SerialsTable extends Serials with TableInfo<$SerialsTable, Serial> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SerialsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _orderIdMeta =
      const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
      'order_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _prdOrderNoMeta =
      const VerificationMeta('prdOrderNo');
  @override
  late final GeneratedColumn<String> prdOrderNo = GeneratedColumn<String>(
      'prd_order_no', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _itemCodeMeta =
      const VerificationMeta('itemCode');
  @override
  late final GeneratedColumn<String> itemCode = GeneratedColumn<String>(
      'item_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _serialUnitMeta =
      const VerificationMeta('serialUnit');
  @override
  late final GeneratedColumn<String> serialUnit = GeneratedColumn<String>(
      'serial_unit', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _rMinMeta = const VerificationMeta('rMin');
  @override
  late final GeneratedColumn<double> rMin = GeneratedColumn<double>(
      'r_min', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _rMaxMeta = const VerificationMeta('rMax');
  @override
  late final GeneratedColumn<double> rMax = GeneratedColumn<double>(
      'r_max', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _cuF0Meta = const VerificationMeta('cuF0');
  @override
  late final GeneratedColumn<double> cuF0 = GeneratedColumn<double>(
      'cu_f0', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _cuF10Meta = const VerificationMeta('cuF10');
  @override
  late final GeneratedColumn<double> cuF10 = GeneratedColumn<double>(
      'cu_f10', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _hvTestMeta = const VerificationMeta('hvTest');
  @override
  late final GeneratedColumn<double> hvTest = GeneratedColumn<double>(
      'hv_test', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _cL1L2Meta = const VerificationMeta('cL1L2');
  @override
  late final GeneratedColumn<double> cL1L2 = GeneratedColumn<double>(
      'c_l1_l2', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _cL2L3Meta = const VerificationMeta('cL2L3');
  @override
  late final GeneratedColumn<double> cL2L3 = GeneratedColumn<double>(
      'c_l2_l3', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _cL3L1Meta = const VerificationMeta('cL3L1');
  @override
  late final GeneratedColumn<double> cL3L1 = GeneratedColumn<double>(
      'c_l3_l1', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _isSendMeta = const VerificationMeta('isSend');
  @override
  late final GeneratedColumn<bool> isSend =
      GeneratedColumn<bool>('is_send', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_send" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _testPassMeta =
      const VerificationMeta('testPass');
  @override
  late final GeneratedColumn<String> testPass = GeneratedColumn<String>(
      'test_pass', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        orderId,
        prdOrderNo,
        itemCode,
        quantity,
        description,
        serialUnit,
        rMin,
        rMax,
        cuF0,
        cuF10,
        hvTest,
        cL1L2,
        cL2L3,
        cL3L1,
        isSend,
        testPass
      ];
  @override
  String get aliasedName => _alias ?? 'serials';
  @override
  String get actualTableName => 'serials';
  @override
  VerificationContext validateIntegrity(Insertable<Serial> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    }
    if (data.containsKey('prd_order_no')) {
      context.handle(
          _prdOrderNoMeta,
          prdOrderNo.isAcceptableOrUnknown(
              data['prd_order_no']!, _prdOrderNoMeta));
    }
    if (data.containsKey('item_code')) {
      context.handle(_itemCodeMeta,
          itemCode.isAcceptableOrUnknown(data['item_code']!, _itemCodeMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('serial_unit')) {
      context.handle(
          _serialUnitMeta,
          serialUnit.isAcceptableOrUnknown(
              data['serial_unit']!, _serialUnitMeta));
    }
    if (data.containsKey('r_min')) {
      context.handle(
          _rMinMeta, rMin.isAcceptableOrUnknown(data['r_min']!, _rMinMeta));
    }
    if (data.containsKey('r_max')) {
      context.handle(
          _rMaxMeta, rMax.isAcceptableOrUnknown(data['r_max']!, _rMaxMeta));
    }
    if (data.containsKey('cu_f0')) {
      context.handle(
          _cuF0Meta, cuF0.isAcceptableOrUnknown(data['cu_f0']!, _cuF0Meta));
    }
    if (data.containsKey('cu_f10')) {
      context.handle(
          _cuF10Meta, cuF10.isAcceptableOrUnknown(data['cu_f10']!, _cuF10Meta));
    }
    if (data.containsKey('hv_test')) {
      context.handle(_hvTestMeta,
          hvTest.isAcceptableOrUnknown(data['hv_test']!, _hvTestMeta));
    }
    if (data.containsKey('c_l1_l2')) {
      context.handle(_cL1L2Meta,
          cL1L2.isAcceptableOrUnknown(data['c_l1_l2']!, _cL1L2Meta));
    }
    if (data.containsKey('c_l2_l3')) {
      context.handle(_cL2L3Meta,
          cL2L3.isAcceptableOrUnknown(data['c_l2_l3']!, _cL2L3Meta));
    }
    if (data.containsKey('c_l3_l1')) {
      context.handle(_cL3L1Meta,
          cL3L1.isAcceptableOrUnknown(data['c_l3_l1']!, _cL3L1Meta));
    }
    if (data.containsKey('is_send')) {
      context.handle(_isSendMeta,
          isSend.isAcceptableOrUnknown(data['is_send']!, _isSendMeta));
    }
    if (data.containsKey('test_pass')) {
      context.handle(_testPassMeta,
          testPass.isAcceptableOrUnknown(data['test_pass']!, _testPassMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Serial map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Serial(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      orderId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_id']),
      prdOrderNo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}prd_order_no']),
      itemCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_code']),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      serialUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}serial_unit']),
      rMin: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}r_min']),
      rMax: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}r_max']),
      cuF0: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cu_f0']),
      cuF10: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cu_f10']),
      hvTest: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}hv_test']),
      cL1L2: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}c_l1_l2']),
      cL2L3: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}c_l2_l3']),
      cL3L1: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}c_l3_l1']),
      isSend: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_send']),
      testPass: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}test_pass']),
    );
  }

  @override
  $SerialsTable createAlias(String alias) {
    return $SerialsTable(attachedDatabase, alias);
  }
}

class Serial extends DataClass implements Insertable<Serial> {
  final int id;
  final String? orderId;
  final String? prdOrderNo;
  final String? itemCode;
  final int? quantity;
  final String? description;
  final String? serialUnit;
  final double? rMin;
  final double? rMax;
  final double? cuF0;
  final double? cuF10;
  final double? hvTest;
  final double? cL1L2;
  final double? cL2L3;
  final double? cL3L1;
  final bool? isSend;
  final String? testPass;
  const Serial(
      {required this.id,
      this.orderId,
      this.prdOrderNo,
      this.itemCode,
      this.quantity,
      this.description,
      this.serialUnit,
      this.rMin,
      this.rMax,
      this.cuF0,
      this.cuF10,
      this.hvTest,
      this.cL1L2,
      this.cL2L3,
      this.cL3L1,
      this.isSend,
      this.testPass});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || orderId != null) {
      map['order_id'] = Variable<String>(orderId);
    }
    if (!nullToAbsent || prdOrderNo != null) {
      map['prd_order_no'] = Variable<String>(prdOrderNo);
    }
    if (!nullToAbsent || itemCode != null) {
      map['item_code'] = Variable<String>(itemCode);
    }
    if (!nullToAbsent || quantity != null) {
      map['quantity'] = Variable<int>(quantity);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || serialUnit != null) {
      map['serial_unit'] = Variable<String>(serialUnit);
    }
    if (!nullToAbsent || rMin != null) {
      map['r_min'] = Variable<double>(rMin);
    }
    if (!nullToAbsent || rMax != null) {
      map['r_max'] = Variable<double>(rMax);
    }
    if (!nullToAbsent || cuF0 != null) {
      map['cu_f0'] = Variable<double>(cuF0);
    }
    if (!nullToAbsent || cuF10 != null) {
      map['cu_f10'] = Variable<double>(cuF10);
    }
    if (!nullToAbsent || hvTest != null) {
      map['hv_test'] = Variable<double>(hvTest);
    }
    if (!nullToAbsent || cL1L2 != null) {
      map['c_l1_l2'] = Variable<double>(cL1L2);
    }
    if (!nullToAbsent || cL2L3 != null) {
      map['c_l2_l3'] = Variable<double>(cL2L3);
    }
    if (!nullToAbsent || cL3L1 != null) {
      map['c_l3_l1'] = Variable<double>(cL3L1);
    }
    if (!nullToAbsent || isSend != null) {
      map['is_send'] = Variable<bool>(isSend);
    }
    if (!nullToAbsent || testPass != null) {
      map['test_pass'] = Variable<String>(testPass);
    }
    return map;
  }

  SerialsCompanion toCompanion(bool nullToAbsent) {
    return SerialsCompanion(
      id: Value(id),
      orderId: orderId == null && nullToAbsent
          ? const Value.absent()
          : Value(orderId),
      prdOrderNo: prdOrderNo == null && nullToAbsent
          ? const Value.absent()
          : Value(prdOrderNo),
      itemCode: itemCode == null && nullToAbsent
          ? const Value.absent()
          : Value(itemCode),
      quantity: quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(quantity),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      serialUnit: serialUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(serialUnit),
      rMin: rMin == null && nullToAbsent ? const Value.absent() : Value(rMin),
      rMax: rMax == null && nullToAbsent ? const Value.absent() : Value(rMax),
      cuF0: cuF0 == null && nullToAbsent ? const Value.absent() : Value(cuF0),
      cuF10:
          cuF10 == null && nullToAbsent ? const Value.absent() : Value(cuF10),
      hvTest:
          hvTest == null && nullToAbsent ? const Value.absent() : Value(hvTest),
      cL1L2:
          cL1L2 == null && nullToAbsent ? const Value.absent() : Value(cL1L2),
      cL2L3:
          cL2L3 == null && nullToAbsent ? const Value.absent() : Value(cL2L3),
      cL3L1:
          cL3L1 == null && nullToAbsent ? const Value.absent() : Value(cL3L1),
      isSend:
          isSend == null && nullToAbsent ? const Value.absent() : Value(isSend),
      testPass: testPass == null && nullToAbsent
          ? const Value.absent()
          : Value(testPass),
    );
  }

  factory Serial.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Serial(
      id: serializer.fromJson<int>(json['id']),
      orderId: serializer.fromJson<String?>(json['orderId']),
      prdOrderNo: serializer.fromJson<String?>(json['prdOrderNo']),
      itemCode: serializer.fromJson<String?>(json['itemCode']),
      quantity: serializer.fromJson<int?>(json['quantity']),
      description: serializer.fromJson<String?>(json['description']),
      serialUnit: serializer.fromJson<String?>(json['serialUnit']),
      rMin: serializer.fromJson<double?>(json['rMin']),
      rMax: serializer.fromJson<double?>(json['rMax']),
      cuF0: serializer.fromJson<double?>(json['cuF0']),
      cuF10: serializer.fromJson<double?>(json['cuF10']),
      hvTest: serializer.fromJson<double?>(json['hvTest']),
      cL1L2: serializer.fromJson<double?>(json['cL1L2']),
      cL2L3: serializer.fromJson<double?>(json['cL2L3']),
      cL3L1: serializer.fromJson<double?>(json['cL3L1']),
      isSend: serializer.fromJson<bool?>(json['isSend']),
      testPass: serializer.fromJson<String?>(json['testPass']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orderId': serializer.toJson<String?>(orderId),
      'prdOrderNo': serializer.toJson<String?>(prdOrderNo),
      'itemCode': serializer.toJson<String?>(itemCode),
      'quantity': serializer.toJson<int?>(quantity),
      'description': serializer.toJson<String?>(description),
      'serialUnit': serializer.toJson<String?>(serialUnit),
      'rMin': serializer.toJson<double?>(rMin),
      'rMax': serializer.toJson<double?>(rMax),
      'cuF0': serializer.toJson<double?>(cuF0),
      'cuF10': serializer.toJson<double?>(cuF10),
      'hvTest': serializer.toJson<double?>(hvTest),
      'cL1L2': serializer.toJson<double?>(cL1L2),
      'cL2L3': serializer.toJson<double?>(cL2L3),
      'cL3L1': serializer.toJson<double?>(cL3L1),
      'isSend': serializer.toJson<bool?>(isSend),
      'testPass': serializer.toJson<String?>(testPass),
    };
  }

  Serial copyWith(
          {int? id,
          Value<String?> orderId = const Value.absent(),
          Value<String?> prdOrderNo = const Value.absent(),
          Value<String?> itemCode = const Value.absent(),
          Value<int?> quantity = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<String?> serialUnit = const Value.absent(),
          Value<double?> rMin = const Value.absent(),
          Value<double?> rMax = const Value.absent(),
          Value<double?> cuF0 = const Value.absent(),
          Value<double?> cuF10 = const Value.absent(),
          Value<double?> hvTest = const Value.absent(),
          Value<double?> cL1L2 = const Value.absent(),
          Value<double?> cL2L3 = const Value.absent(),
          Value<double?> cL3L1 = const Value.absent(),
          Value<bool?> isSend = const Value.absent(),
          Value<String?> testPass = const Value.absent()}) =>
      Serial(
        id: id ?? this.id,
        orderId: orderId.present ? orderId.value : this.orderId,
        prdOrderNo: prdOrderNo.present ? prdOrderNo.value : this.prdOrderNo,
        itemCode: itemCode.present ? itemCode.value : this.itemCode,
        quantity: quantity.present ? quantity.value : this.quantity,
        description: description.present ? description.value : this.description,
        serialUnit: serialUnit.present ? serialUnit.value : this.serialUnit,
        rMin: rMin.present ? rMin.value : this.rMin,
        rMax: rMax.present ? rMax.value : this.rMax,
        cuF0: cuF0.present ? cuF0.value : this.cuF0,
        cuF10: cuF10.present ? cuF10.value : this.cuF10,
        hvTest: hvTest.present ? hvTest.value : this.hvTest,
        cL1L2: cL1L2.present ? cL1L2.value : this.cL1L2,
        cL2L3: cL2L3.present ? cL2L3.value : this.cL2L3,
        cL3L1: cL3L1.present ? cL3L1.value : this.cL3L1,
        isSend: isSend.present ? isSend.value : this.isSend,
        testPass: testPass.present ? testPass.value : this.testPass,
      );
  @override
  String toString() {
    return (StringBuffer('Serial(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('prdOrderNo: $prdOrderNo, ')
          ..write('itemCode: $itemCode, ')
          ..write('quantity: $quantity, ')
          ..write('description: $description, ')
          ..write('serialUnit: $serialUnit, ')
          ..write('rMin: $rMin, ')
          ..write('rMax: $rMax, ')
          ..write('cuF0: $cuF0, ')
          ..write('cuF10: $cuF10, ')
          ..write('hvTest: $hvTest, ')
          ..write('cL1L2: $cL1L2, ')
          ..write('cL2L3: $cL2L3, ')
          ..write('cL3L1: $cL3L1, ')
          ..write('isSend: $isSend, ')
          ..write('testPass: $testPass')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      orderId,
      prdOrderNo,
      itemCode,
      quantity,
      description,
      serialUnit,
      rMin,
      rMax,
      cuF0,
      cuF10,
      hvTest,
      cL1L2,
      cL2L3,
      cL3L1,
      isSend,
      testPass);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Serial &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.prdOrderNo == this.prdOrderNo &&
          other.itemCode == this.itemCode &&
          other.quantity == this.quantity &&
          other.description == this.description &&
          other.serialUnit == this.serialUnit &&
          other.rMin == this.rMin &&
          other.rMax == this.rMax &&
          other.cuF0 == this.cuF0 &&
          other.cuF10 == this.cuF10 &&
          other.hvTest == this.hvTest &&
          other.cL1L2 == this.cL1L2 &&
          other.cL2L3 == this.cL2L3 &&
          other.cL3L1 == this.cL3L1 &&
          other.isSend == this.isSend &&
          other.testPass == this.testPass);
}

class SerialsCompanion extends UpdateCompanion<Serial> {
  final Value<int> id;
  final Value<String?> orderId;
  final Value<String?> prdOrderNo;
  final Value<String?> itemCode;
  final Value<int?> quantity;
  final Value<String?> description;
  final Value<String?> serialUnit;
  final Value<double?> rMin;
  final Value<double?> rMax;
  final Value<double?> cuF0;
  final Value<double?> cuF10;
  final Value<double?> hvTest;
  final Value<double?> cL1L2;
  final Value<double?> cL2L3;
  final Value<double?> cL3L1;
  final Value<bool?> isSend;
  final Value<String?> testPass;
  const SerialsCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.prdOrderNo = const Value.absent(),
    this.itemCode = const Value.absent(),
    this.quantity = const Value.absent(),
    this.description = const Value.absent(),
    this.serialUnit = const Value.absent(),
    this.rMin = const Value.absent(),
    this.rMax = const Value.absent(),
    this.cuF0 = const Value.absent(),
    this.cuF10 = const Value.absent(),
    this.hvTest = const Value.absent(),
    this.cL1L2 = const Value.absent(),
    this.cL2L3 = const Value.absent(),
    this.cL3L1 = const Value.absent(),
    this.isSend = const Value.absent(),
    this.testPass = const Value.absent(),
  });
  SerialsCompanion.insert({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.prdOrderNo = const Value.absent(),
    this.itemCode = const Value.absent(),
    this.quantity = const Value.absent(),
    this.description = const Value.absent(),
    this.serialUnit = const Value.absent(),
    this.rMin = const Value.absent(),
    this.rMax = const Value.absent(),
    this.cuF0 = const Value.absent(),
    this.cuF10 = const Value.absent(),
    this.hvTest = const Value.absent(),
    this.cL1L2 = const Value.absent(),
    this.cL2L3 = const Value.absent(),
    this.cL3L1 = const Value.absent(),
    this.isSend = const Value.absent(),
    this.testPass = const Value.absent(),
  });
  static Insertable<Serial> custom({
    Expression<int>? id,
    Expression<String>? orderId,
    Expression<String>? prdOrderNo,
    Expression<String>? itemCode,
    Expression<int>? quantity,
    Expression<String>? description,
    Expression<String>? serialUnit,
    Expression<double>? rMin,
    Expression<double>? rMax,
    Expression<double>? cuF0,
    Expression<double>? cuF10,
    Expression<double>? hvTest,
    Expression<double>? cL1L2,
    Expression<double>? cL2L3,
    Expression<double>? cL3L1,
    Expression<bool>? isSend,
    Expression<String>? testPass,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (prdOrderNo != null) 'prd_order_no': prdOrderNo,
      if (itemCode != null) 'item_code': itemCode,
      if (quantity != null) 'quantity': quantity,
      if (description != null) 'description': description,
      if (serialUnit != null) 'serial_unit': serialUnit,
      if (rMin != null) 'r_min': rMin,
      if (rMax != null) 'r_max': rMax,
      if (cuF0 != null) 'cu_f0': cuF0,
      if (cuF10 != null) 'cu_f10': cuF10,
      if (hvTest != null) 'hv_test': hvTest,
      if (cL1L2 != null) 'c_l1_l2': cL1L2,
      if (cL2L3 != null) 'c_l2_l3': cL2L3,
      if (cL3L1 != null) 'c_l3_l1': cL3L1,
      if (isSend != null) 'is_send': isSend,
      if (testPass != null) 'test_pass': testPass,
    });
  }

  SerialsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? orderId,
      Value<String?>? prdOrderNo,
      Value<String?>? itemCode,
      Value<int?>? quantity,
      Value<String?>? description,
      Value<String?>? serialUnit,
      Value<double?>? rMin,
      Value<double?>? rMax,
      Value<double?>? cuF0,
      Value<double?>? cuF10,
      Value<double?>? hvTest,
      Value<double?>? cL1L2,
      Value<double?>? cL2L3,
      Value<double?>? cL3L1,
      Value<bool?>? isSend,
      Value<String?>? testPass}) {
    return SerialsCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      prdOrderNo: prdOrderNo ?? this.prdOrderNo,
      itemCode: itemCode ?? this.itemCode,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
      serialUnit: serialUnit ?? this.serialUnit,
      rMin: rMin ?? this.rMin,
      rMax: rMax ?? this.rMax,
      cuF0: cuF0 ?? this.cuF0,
      cuF10: cuF10 ?? this.cuF10,
      hvTest: hvTest ?? this.hvTest,
      cL1L2: cL1L2 ?? this.cL1L2,
      cL2L3: cL2L3 ?? this.cL2L3,
      cL3L1: cL3L1 ?? this.cL3L1,
      isSend: isSend ?? this.isSend,
      testPass: testPass ?? this.testPass,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (prdOrderNo.present) {
      map['prd_order_no'] = Variable<String>(prdOrderNo.value);
    }
    if (itemCode.present) {
      map['item_code'] = Variable<String>(itemCode.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (serialUnit.present) {
      map['serial_unit'] = Variable<String>(serialUnit.value);
    }
    if (rMin.present) {
      map['r_min'] = Variable<double>(rMin.value);
    }
    if (rMax.present) {
      map['r_max'] = Variable<double>(rMax.value);
    }
    if (cuF0.present) {
      map['cu_f0'] = Variable<double>(cuF0.value);
    }
    if (cuF10.present) {
      map['cu_f10'] = Variable<double>(cuF10.value);
    }
    if (hvTest.present) {
      map['hv_test'] = Variable<double>(hvTest.value);
    }
    if (cL1L2.present) {
      map['c_l1_l2'] = Variable<double>(cL1L2.value);
    }
    if (cL2L3.present) {
      map['c_l2_l3'] = Variable<double>(cL2L3.value);
    }
    if (cL3L1.present) {
      map['c_l3_l1'] = Variable<double>(cL3L1.value);
    }
    if (isSend.present) {
      map['is_send'] = Variable<bool>(isSend.value);
    }
    if (testPass.present) {
      map['test_pass'] = Variable<String>(testPass.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SerialsCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('prdOrderNo: $prdOrderNo, ')
          ..write('itemCode: $itemCode, ')
          ..write('quantity: $quantity, ')
          ..write('description: $description, ')
          ..write('serialUnit: $serialUnit, ')
          ..write('rMin: $rMin, ')
          ..write('rMax: $rMax, ')
          ..write('cuF0: $cuF0, ')
          ..write('cuF10: $cuF10, ')
          ..write('hvTest: $hvTest, ')
          ..write('cL1L2: $cL1L2, ')
          ..write('cL2L3: $cL2L3, ')
          ..write('cL3L1: $cL3L1, ')
          ..write('isSend: $isSend, ')
          ..write('testPass: $testPass')
          ..write(')'))
        .toString();
  }
}

class SerialsViewData extends DataClass {
  final String? orderId;
  final String? prdOrderNo;
  final String? itemCode;
  final int? quantity;
  final String? description;
  final String? serialUnit;
  final double? rMin;
  final double? rMax;
  final double? cuF0;
  final double? cuF10;
  final double? hvTest;
  final double? cL1L2;
  final double? cL2L3;
  final double? cL3L1;
  final bool? isSend;
  final String? testPass;
  const SerialsViewData(
      {this.orderId,
      this.prdOrderNo,
      this.itemCode,
      this.quantity,
      this.description,
      this.serialUnit,
      this.rMin,
      this.rMax,
      this.cuF0,
      this.cuF10,
      this.hvTest,
      this.cL1L2,
      this.cL2L3,
      this.cL3L1,
      this.isSend,
      this.testPass});
  factory SerialsViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SerialsViewData(
      orderId: serializer.fromJson<String?>(json['orderId']),
      prdOrderNo: serializer.fromJson<String?>(json['prdOrderNo']),
      itemCode: serializer.fromJson<String?>(json['itemCode']),
      quantity: serializer.fromJson<int?>(json['quantity']),
      description: serializer.fromJson<String?>(json['description']),
      serialUnit: serializer.fromJson<String?>(json['serialUnit']),
      rMin: serializer.fromJson<double?>(json['rMin']),
      rMax: serializer.fromJson<double?>(json['rMax']),
      cuF0: serializer.fromJson<double?>(json['cuF0']),
      cuF10: serializer.fromJson<double?>(json['cuF10']),
      hvTest: serializer.fromJson<double?>(json['hvTest']),
      cL1L2: serializer.fromJson<double?>(json['cL1L2']),
      cL2L3: serializer.fromJson<double?>(json['cL2L3']),
      cL3L1: serializer.fromJson<double?>(json['cL3L1']),
      isSend: serializer.fromJson<bool?>(json['isSend']),
      testPass: serializer.fromJson<String?>(json['testPass']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'orderId': serializer.toJson<String?>(orderId),
      'prdOrderNo': serializer.toJson<String?>(prdOrderNo),
      'itemCode': serializer.toJson<String?>(itemCode),
      'quantity': serializer.toJson<int?>(quantity),
      'description': serializer.toJson<String?>(description),
      'serialUnit': serializer.toJson<String?>(serialUnit),
      'rMin': serializer.toJson<double?>(rMin),
      'rMax': serializer.toJson<double?>(rMax),
      'cuF0': serializer.toJson<double?>(cuF0),
      'cuF10': serializer.toJson<double?>(cuF10),
      'hvTest': serializer.toJson<double?>(hvTest),
      'cL1L2': serializer.toJson<double?>(cL1L2),
      'cL2L3': serializer.toJson<double?>(cL2L3),
      'cL3L1': serializer.toJson<double?>(cL3L1),
      'isSend': serializer.toJson<bool?>(isSend),
      'testPass': serializer.toJson<String?>(testPass),
    };
  }

  SerialsViewData copyWith(
          {Value<String?> orderId = const Value.absent(),
          Value<String?> prdOrderNo = const Value.absent(),
          Value<String?> itemCode = const Value.absent(),
          Value<int?> quantity = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<String?> serialUnit = const Value.absent(),
          Value<double?> rMin = const Value.absent(),
          Value<double?> rMax = const Value.absent(),
          Value<double?> cuF0 = const Value.absent(),
          Value<double?> cuF10 = const Value.absent(),
          Value<double?> hvTest = const Value.absent(),
          Value<double?> cL1L2 = const Value.absent(),
          Value<double?> cL2L3 = const Value.absent(),
          Value<double?> cL3L1 = const Value.absent(),
          Value<bool?> isSend = const Value.absent(),
          Value<String?> testPass = const Value.absent()}) =>
      SerialsViewData(
        orderId: orderId.present ? orderId.value : this.orderId,
        prdOrderNo: prdOrderNo.present ? prdOrderNo.value : this.prdOrderNo,
        itemCode: itemCode.present ? itemCode.value : this.itemCode,
        quantity: quantity.present ? quantity.value : this.quantity,
        description: description.present ? description.value : this.description,
        serialUnit: serialUnit.present ? serialUnit.value : this.serialUnit,
        rMin: rMin.present ? rMin.value : this.rMin,
        rMax: rMax.present ? rMax.value : this.rMax,
        cuF0: cuF0.present ? cuF0.value : this.cuF0,
        cuF10: cuF10.present ? cuF10.value : this.cuF10,
        hvTest: hvTest.present ? hvTest.value : this.hvTest,
        cL1L2: cL1L2.present ? cL1L2.value : this.cL1L2,
        cL2L3: cL2L3.present ? cL2L3.value : this.cL2L3,
        cL3L1: cL3L1.present ? cL3L1.value : this.cL3L1,
        isSend: isSend.present ? isSend.value : this.isSend,
        testPass: testPass.present ? testPass.value : this.testPass,
      );
  @override
  String toString() {
    return (StringBuffer('SerialsViewData(')
          ..write('orderId: $orderId, ')
          ..write('prdOrderNo: $prdOrderNo, ')
          ..write('itemCode: $itemCode, ')
          ..write('quantity: $quantity, ')
          ..write('description: $description, ')
          ..write('serialUnit: $serialUnit, ')
          ..write('rMin: $rMin, ')
          ..write('rMax: $rMax, ')
          ..write('cuF0: $cuF0, ')
          ..write('cuF10: $cuF10, ')
          ..write('hvTest: $hvTest, ')
          ..write('cL1L2: $cL1L2, ')
          ..write('cL2L3: $cL2L3, ')
          ..write('cL3L1: $cL3L1, ')
          ..write('isSend: $isSend, ')
          ..write('testPass: $testPass')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      orderId,
      prdOrderNo,
      itemCode,
      quantity,
      description,
      serialUnit,
      rMin,
      rMax,
      cuF0,
      cuF10,
      hvTest,
      cL1L2,
      cL2L3,
      cL3L1,
      isSend,
      testPass);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SerialsViewData &&
          other.orderId == this.orderId &&
          other.prdOrderNo == this.prdOrderNo &&
          other.itemCode == this.itemCode &&
          other.quantity == this.quantity &&
          other.description == this.description &&
          other.serialUnit == this.serialUnit &&
          other.rMin == this.rMin &&
          other.rMax == this.rMax &&
          other.cuF0 == this.cuF0 &&
          other.cuF10 == this.cuF10 &&
          other.hvTest == this.hvTest &&
          other.cL1L2 == this.cL1L2 &&
          other.cL2L3 == this.cL2L3 &&
          other.cL3L1 == this.cL3L1 &&
          other.isSend == this.isSend &&
          other.testPass == this.testPass);
}

class $SerialsViewView extends ViewInfo<$SerialsViewView, SerialsViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$AppDb attachedDatabase;
  $SerialsViewView(this.attachedDatabase, [this._alias]);
  $SerialsTable get serials => attachedDatabase.serials.createAlias('t0');
  @override
  List<GeneratedColumn> get $columns => [
        orderId,
        prdOrderNo,
        itemCode,
        quantity,
        description,
        serialUnit,
        rMin,
        rMax,
        cuF0,
        cuF10,
        hvTest,
        cL1L2,
        cL2L3,
        cL3L1,
        isSend,
        testPass
      ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'serials_view';
  @override
  String? get createViewStmt => null;
  @override
  $SerialsViewView get asDslTable => this;
  @override
  SerialsViewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SerialsViewData(
      orderId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_id']),
      prdOrderNo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}prd_order_no']),
      itemCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_code']),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      serialUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}serial_unit']),
      rMin: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}r_min']),
      rMax: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}r_max']),
      cuF0: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cu_f0']),
      cuF10: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cu_f10']),
      hvTest: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}hv_test']),
      cL1L2: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}c_l1_l2']),
      cL2L3: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}c_l2_l3']),
      cL3L1: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}c_l3_l1']),
      isSend: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_send']),
      testPass: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}test_pass']),
    );
  }

  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
      'order_id', aliasedName, true,
      generatedAs: GeneratedAs(serials.orderId, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> prdOrderNo = GeneratedColumn<String>(
      'prd_order_no', aliasedName, true,
      generatedAs: GeneratedAs(serials.prdOrderNo, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> itemCode = GeneratedColumn<String>(
      'item_code', aliasedName, true,
      generatedAs: GeneratedAs(serials.itemCode, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, true,
      generatedAs: GeneratedAs(serials.quantity, false),
      type: DriftSqlType.int);
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      generatedAs: GeneratedAs(serials.description, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> serialUnit = GeneratedColumn<String>(
      'serial_unit', aliasedName, true,
      generatedAs: GeneratedAs(serials.serialUnit, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<double> rMin = GeneratedColumn<double>(
      'r_min', aliasedName, true,
      generatedAs: GeneratedAs(serials.rMin, false), type: DriftSqlType.double);
  late final GeneratedColumn<double> rMax = GeneratedColumn<double>(
      'r_max', aliasedName, true,
      generatedAs: GeneratedAs(serials.rMax, false), type: DriftSqlType.double);
  late final GeneratedColumn<double> cuF0 = GeneratedColumn<double>(
      'cu_f0', aliasedName, true,
      generatedAs: GeneratedAs(serials.cuF0, false), type: DriftSqlType.double);
  late final GeneratedColumn<double> cuF10 = GeneratedColumn<double>(
      'cu_f10', aliasedName, true,
      generatedAs: GeneratedAs(serials.cuF10, false),
      type: DriftSqlType.double);
  late final GeneratedColumn<double> hvTest = GeneratedColumn<double>(
      'hv_test', aliasedName, true,
      generatedAs: GeneratedAs(serials.hvTest, false),
      type: DriftSqlType.double);
  late final GeneratedColumn<double> cL1L2 = GeneratedColumn<double>(
      'c_l1_l2', aliasedName, true,
      generatedAs: GeneratedAs(serials.cL1L2, false),
      type: DriftSqlType.double);
  late final GeneratedColumn<double> cL2L3 = GeneratedColumn<double>(
      'c_l2_l3', aliasedName, true,
      generatedAs: GeneratedAs(serials.cL2L3, false),
      type: DriftSqlType.double);
  late final GeneratedColumn<double> cL3L1 = GeneratedColumn<double>(
      'c_l3_l1', aliasedName, true,
      generatedAs: GeneratedAs(serials.cL3L1, false),
      type: DriftSqlType.double);
  late final GeneratedColumn<bool> isSend =
      GeneratedColumn<bool>('is_send', aliasedName, true,
          generatedAs: GeneratedAs(serials.isSend, false),
          type: DriftSqlType.bool,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_send" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  late final GeneratedColumn<String> testPass = GeneratedColumn<String>(
      'test_pass', aliasedName, true,
      generatedAs: GeneratedAs(serials.testPass, false),
      type: DriftSqlType.string);
  @override
  $SerialsViewView createAlias(String alias) {
    return $SerialsViewView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(serials)..addColumns($columns));
  @override
  Set<String> get readTables => const {'serials'};
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  late final $SerialsTable serials = $SerialsTable(this);
  late final $SerialsViewView serialsView = $SerialsViewView(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [serials, serialsView];
}
