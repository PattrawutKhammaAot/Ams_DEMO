class TransferAssetOutputModel {
  const TransferAssetOutputModel({
    this.MOVE_NEW_COMPANYID,
    this.MOVE_NEW_BRANCHID,
    this.MOVE_NEW_COSTCENTERID,
    this.MOVE_NEW_BUILDINGID,
    this.MOVE_NEW_FLOORID,
    this.MOVE_NEW_ROOMID,
    this.MOVE_NEW_LOCATIONID,
    this.MOVE_NEW_DEPARTMENTID,
    this.MOVE_NEW_OWNERID,
    this.MOVE_DATE,
    this.MOVE_REMARK,
    this.UDF_1,
    this.UDF_2,
    this.UDF_3,
    this.CREATE_BY,
    this.CREATE_DATE,
    this.LIST_ASSET_ID,
  });

  final int? MOVE_NEW_COMPANYID;
  final int? MOVE_NEW_BRANCHID;
  final int? MOVE_NEW_COSTCENTERID;
  final int? MOVE_NEW_BUILDINGID;
  final int? MOVE_NEW_FLOORID;
  final int? MOVE_NEW_ROOMID;
  final int? MOVE_NEW_LOCATIONID;
  final int? MOVE_NEW_DEPARTMENTID;
  final int? MOVE_NEW_OWNERID;
  final String? MOVE_DATE;
  final String? MOVE_REMARK;
  final String? UDF_1;
  final String? UDF_2;
  final String? UDF_3;
  final int? CREATE_BY;
  final String? CREATE_DATE;
  final List<int>? LIST_ASSET_ID;

  List<Object> get props => [
        MOVE_NEW_COMPANYID!,
        MOVE_NEW_BRANCHID!,
        MOVE_NEW_COSTCENTERID!,
        MOVE_NEW_BUILDINGID!,
        MOVE_NEW_FLOORID!,
        MOVE_NEW_ROOMID!,
        MOVE_NEW_LOCATIONID!,
        MOVE_NEW_DEPARTMENTID!,
        MOVE_NEW_OWNERID!,
        MOVE_DATE!,
        MOVE_REMARK!,
        UDF_1!,
        UDF_2!,
        UDF_3!,
        CREATE_BY!,
        CREATE_DATE!,
        LIST_ASSET_ID!,
      ];

  static TransferAssetOutputModel fromJson(dynamic json) {
    return TransferAssetOutputModel(
      MOVE_NEW_COMPANYID: json['moveNewCompanyId'],
      MOVE_NEW_BRANCHID: json['moveNewBranchId'],
      MOVE_NEW_COSTCENTERID: json['moveNewCostCenterId'],
      MOVE_NEW_BUILDINGID: json['moveNewBuildingId'],
      MOVE_NEW_FLOORID: json['moveNewFloorId'],
      MOVE_NEW_ROOMID: json['moveNewRoomId'],
      MOVE_NEW_LOCATIONID: json['moveNewLocationId'],
      MOVE_NEW_DEPARTMENTID: json['moveNewDepartmentId'],
      MOVE_NEW_OWNERID: json['moveNewOwnerId'],
      MOVE_DATE: json['moveDate'],
      MOVE_REMARK: json['moveRemark'],
      UDF_1: json['udf1'],
      UDF_2: json['udf2'],
      UDF_3: json['udf3'],
      CREATE_BY: json['createBy'],
      CREATE_DATE: json['createDate'],
      LIST_ASSET_ID: json['listAssetId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'moveNewCompanyId': MOVE_NEW_COMPANYID,
        'moveNewBranchId': MOVE_NEW_BRANCHID,
        'moveNewCostCenterId': MOVE_NEW_COSTCENTERID,
        'moveNewBuildingId': MOVE_NEW_BUILDINGID,
        'moveNewFloorId': MOVE_NEW_FLOORID,
        'moveNewRoomId': MOVE_NEW_ROOMID,
        'moveNewLocationId': MOVE_NEW_LOCATIONID,
        'moveNewDepartmentId': MOVE_NEW_DEPARTMENTID,
        'moveNewOwnerId': MOVE_NEW_OWNERID,
        'moveDate': MOVE_DATE,
        'moveRemark': MOVE_REMARK,
        'udf1': UDF_1,
        'udf2': UDF_2,
        'udf3': UDF_3,
        'createBy': CREATE_BY,
        'createDate': CREATE_DATE,
        'listAssetId': LIST_ASSET_ID,
      };
}
