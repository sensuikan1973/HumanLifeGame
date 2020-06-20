import 'package:HumanLifeGame/api/firestore/service_control.dart';
import 'package:HumanLifeGame/screens/maintenance/maintenance.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('not under maintenance', (tester) async {
    final serviceControlData = {
      ServiceControlField.isMaintenance: false,
      ServiceControlField.requiredMinVersion: 'X.Y.Z',
      TimestampField.createdAt: DateTime.now(),
      TimestampField.updatedAt: DateTime.now(),
    };
    final firestore = MockFirestoreInstance();
    await firestore
        .collection(ServiceControl.collectionId)
        .document(ServiceControlDocId.web)
        .setData(serviceControlData);

    await tester.pumpWidget(
      Provider<Firestore>(
        create: (context) => firestore,
        child: const MaterialApp(home: Maintenance()),
      ),
    );
    await tester.pump();
    expect(find.byType(Maintenance), findsOneWidget);
    expect(find.text('not under maintenance'), findsOneWidget);
  });

  testWidgets('under maintenance', (tester) async {
    final serviceControlData = {
      ServiceControlField.isMaintenance: true,
      ServiceControlField.requiredMinVersion: 'X.Y.Z',
      TimestampField.createdAt: DateTime.now(),
      TimestampField.updatedAt: DateTime.now(),
    };
    final firestore = MockFirestoreInstance();
    await firestore
        .collection(ServiceControl.collectionId)
        .document(ServiceControlDocId.web)
        .setData(serviceControlData);

    await tester.pumpWidget(
      Provider<Firestore>(
        create: (context) => firestore,
        child: const MaterialApp(home: Maintenance()),
      ),
    );
    await tester.pump();
    expect(find.byType(Maintenance), findsOneWidget);
    expect(find.text('under maintenance'), findsOneWidget);
  });
}
