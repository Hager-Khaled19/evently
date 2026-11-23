import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/event_model.dart';

class EventsProvider extends ChangeNotifier {
  List<EventModel> _events = [];
  StreamSubscription? _sub;
  String? _uid;

  String selectedCategory = 'All';
  String searchQuery = '';

  CollectionReference<Map<String, dynamic>>? get _collection {
    if (_uid == null) return null;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .collection('events');
  }

  void startListening() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    if (_uid == user.uid && _sub != null) return;

    _sub?.cancel();
    _uid = user.uid;
    _sub = _collection!
        .orderBy('date', descending: false)
        .snapshots()
        .listen((snapshot) {
      _events = snapshot.docs
          .map((d) => EventModel.fromMap(d.id, d.data()))
          .toList();
      notifyListeners();
    });
  }

  void stopListening() {
    _sub?.cancel();
    _sub = null;
    _uid = null;
    _events = [];
    selectedCategory = 'All';
    searchQuery = '';
    notifyListeners();
  }

  EventModel? findById(String id) {
    for (final e in _events) {
      if (e.id == id) return e;
    }
    return null;
  }

  List<EventModel> get filteredEvents {
    return _events.where((e) {
      return selectedCategory == 'All' || e.category == selectedCategory;
    }).toList();
  }

  List<EventModel> get favouriteEvents {
    return _events.where((e) {
      final matchSearch = searchQuery.isEmpty ||
          e.title.toLowerCase().contains(searchQuery.toLowerCase());
      return e.isFavourite && matchSearch;
    }).toList();
  }

  void selectCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  void setSearch(String query) {
    searchQuery = query;
    notifyListeners();
  }

  Future<void> addEvent(EventModel event) async {
    await _collection?.add(event.toMap());
  }

  Future<void> updateEvent(EventModel event) async {
    await _collection?.doc(event.id).update(event.toMap());
  }

  Future<void> deleteEvent(EventModel event) async {
    await _collection?.doc(event.id).delete();
  }

  Future<void> toggleFavourite(EventModel event) async {
    await _collection
        ?.doc(event.id)
        .update({'isFavourite': !event.isFavourite});
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}