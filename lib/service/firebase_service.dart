import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_comment/models/book_model.dart';
import 'package:my_comment/models/movie_model.dart';
import 'package:my_comment/models/show_model.dart';
import 'package:my_comment/models/user_model.dart';
import 'package:my_comment/service/user_service.dart';
import 'package:provider/provider.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> getUserDetails(BuildContext context) async {
    User currentUser = _auth.currentUser!;
    return await _firestore
        .collection('users')
        .doc(currentUser.email)
        .get()
        .then((value) {
      dynamic data = value.data();
      if (data != null) {
        UserModel dynamicUser = UserModel.fromMap(data);
        Provider.of<UserService>(context, listen: false).setUser(dynamicUser);
        return dynamicUser;
      }
      return null;
    });
  }

  Future<UserModel> getUserById(String id) async {
    return await _firestore
        .collection('users')
        .where('id', isEqualTo: id)
        .get()
        .then((value) => UserModel.fromMap(value.docs.first.data()));
  }

  addComment(
    BuildContext context,
    Object object,
    String objectId,
    Map<String, dynamic> updatedMap,
    String collection,
  ) async {
    UserModel? user = await getUserDetails(context);
    if (object is MovieModel) {
      List<String> commentsWithId = user!.movieComments;
      commentsWithId.add(objectId);
      await _firestore
          .collection('users')
          .doc(user.email)
          .update({'movieComments': commentsWithId});
    } else if (object is ShowModel) {
      List<String> commentsWithId = user!.showComments;
      commentsWithId.add(objectId);
      await _firestore
          .collection('users')
          .doc(user.email)
          .update({'showComments': commentsWithId});
    } else {
      List<String> commentsWithId = user!.bookComments;
      commentsWithId.add(objectId);
      await _firestore
          .collection('users')
          .doc(user.email)
          .update({'bookComments': commentsWithId});
    }

    await _firestore
        .collection(collection)
        .where('id', isEqualTo: objectId)
        .get()
        .then((value) => value.docs.first.reference.update(updatedMap));
  }

  removeAllComments(BuildContext context, String collection) async {
    await _firestore.collection('${collection}s').get().then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        value.docs[i].reference.update({'comments': {}});
        value.docs[i].reference.update({'ratings': {}});
      }
    }).then((value) async {
      UserModel? user = await getUserDetails(context);
      await _firestore.collection('users').doc(user!.email).update({
        '${collection}Comments': [],
      });
    });
  }

  Future<List<MovieModel>> getAllMovies() async {
    return await _firestore.collection('movies').get().then((value) {
      return value.docs.map((e) => MovieModel.fromMap(e.data())).toList();
    });
  }

  addMovie() async {
    // String uuid = const Uuid().v4();

    // BookModel model = BookModel(
    //     id: uuid,
    //     name: 'Atomik Alışkanlıklar',
    //     author: 'James Clear',
    //     pages: 352,
    //     imagePath:
    //         'https://cdn.dsmcdn.com/ty583/product/media/images/20221101/14/205058687/611045146/1/1_org_zoom.jpg',
    //     comments: {},
    //     ratings: {});
    // await _firestore
    //     .collection('books')
    //     .add(model.toMap())
    //     .then((value) => print('Added'));
  }

  Future<List<ShowModel>> getAllShows() async {
    return await _firestore.collection('shows').get().then((value) {
      return value.docs.map((e) => ShowModel.fromMap(e.data())).toList();
    });
  }

  Future<List<BookModel>> getAllBooks() async {
    return await _firestore.collection('books').get().then((value) {
      return value.docs.map((e) => BookModel.fromMap(e.data())).toList();
    });
  }
}
