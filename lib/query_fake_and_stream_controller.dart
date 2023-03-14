import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_fakes/firestore_fakes.dart';

class QueryFakeAndStreamController {
  QueryFakeAndStreamController(this.queryFake, this.controller);

  final QueryFake queryFake;
  final StreamController<QuerySnapshot<Map<String, dynamic>>> controller;
}
