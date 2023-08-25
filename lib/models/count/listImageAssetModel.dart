import 'dart:io';

import 'package:ams_count/data/database/dbsqlite.dart';
import 'package:ams_count/data/database/quickTypes/quickTypes.dart';
import 'package:ams_count/models/count/uploadImage_output_Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../blocs/count/count_bloc.dart';

class ListImageAssetModel {
  const ListImageAssetModel({
    this.ID,
    this.ASSETS_CODE,
    this.URL_IMAGE,
  });
  final int? ID;
  final String? ASSETS_CODE;
  final String? URL_IMAGE;

  List<Object> get props => [ASSETS_CODE!, URL_IMAGE!];

  static ListImageAssetModel fromJson(dynamic json) {
    return ListImageAssetModel(
      ID: json[ListImageAssetField.ID],
      ASSETS_CODE: json[ListImageAssetField.ASSETS_CODE],
      URL_IMAGE: json[ListImageAssetField.URL_IMAGE],
    );
  }

  createTable(Database db, int newVersion) async {
    await db.execute('CREATE TABLE ${ListImageAssetField.TABLE_NAME} ('
        '${QuickTypes.ID_PRIMARYKEY}, '
        '${ListImageAssetField.ASSETS_CODE} ${QuickTypes.TEXT},'
        '${ListImageAssetField.URL_IMAGE} ${QuickTypes.TEXT}'
        ')');
  }

  Map<String, dynamic> toJson() => {
        ListImageAssetField.ID: ID,
        ListImageAssetField.ASSETS_CODE: ASSETS_CODE,
        ListImageAssetField.URL_IMAGE: URL_IMAGE,
      };

  Future<int> insert(ListImageAssetModel data) async {
    try {
      var itemSql = queryAllRows();
      final db = await DbSqlite().database;

      return await db.insert(ListImageAssetField.TABLE_NAME, data.toJson());
    } on Exception catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<void> addData(ListImageAssetModel data) async {
    var ent = await ListImageAssetModel().getDataById(data.ID);

    if (ent.isEmpty) {
      await ListImageAssetModel().insert(data);
    } else {
      await ListImageAssetModel().update(data, data.ID);
    }
  }

  Future<List<ListImageAssetModel>> getDataById(keyValue) async {
    try {
      final db = await DbSqlite().database;

      var result = await db.query(ListImageAssetField.TABLE_NAME,
          where: '${ListImageAssetField.ID} = ?', whereArgs: [keyValue]);

      return result.map((json) => ListImageAssetModel.fromJson(json)).toList();
    } on Exception catch (ex) {
      rethrow;
    }
  }

  Future<int> update(data, keyValue) async {
    try {
      ListImageAssetModel values = data;
      final db = await DbSqlite().database;
      return await db.update(ListImageAssetField.TABLE_NAME, values.toJson(),
          where: '${ListImageAssetField.ID} = ?', whereArgs: [keyValue]);
    } on Exception catch (ex) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await DbSqlite().database;
    return await db.query(ListImageAssetField.TABLE_NAME);
  }

  Future<void> deleteDataAllFromSQLite() async {
    try {
      Database db = await DbSqlite().database;
      int count = await db.delete(ListImageAssetField.TABLE_NAME);
    } catch (e) {}
  }

  Future<void> deleteDataByID(int id) async {
    try {
      Database db = await DbSqlite().database;
      printInfo(info: "${id}");
      int count = await db.delete(
        ListImageAssetField.TABLE_NAME,
        where: "${ListImageAssetField.ID} = ?",
        whereArgs: [id],
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> uploadImageAndDelete(BuildContext context) async {
    var itemSql = await ListImageAssetModel().queryAllRows();
    if (itemSql.isNotEmpty) {
      for (var item in itemSql) {
        printInfo(info: '${item[ListImageAssetField.ASSETS_CODE]} Test Image');
        printInfo(info: '${item[ListImageAssetField.URL_IMAGE]} Test Image');
        BlocProvider.of<CountBloc>(context).add(UploadImageEvent(
            UploadImageModelOutput(
                ASSETS_CODE: item[ListImageAssetField.ASSETS_CODE],
                FILES: File(item[ListImageAssetField.URL_IMAGE]))));
        deleteDataByID(item[ListImageAssetField.ID]);
        File(item[ListImageAssetField.URL_IMAGE]).deleteSync();
      }
    }
  }
}

class ListImageAssetField {
  static const String TABLE_NAME = 't_listImageAssets';
  static const String ID = 'ID';
  static const String ASSETS_CODE = 'assetCode';
  static const String URL_IMAGE = 'url_image';
}
