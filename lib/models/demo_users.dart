import 'package:flutter/material.dart';

const users = [
  userGordon,
  userSalvatore,
  userSacha,
  userDeven,
  userSahil,
  userReuben,
  userNash,
];

const userGordon = DemoUser(
  id: 'gordon',
  name: 'Gordon Hayes',
  image:
      'https://media.istockphoto.com/photos/millennial-male-team-leader-organize-virtual-workshop-with-employees-picture-id1300972574',
);

const userSalvatore = DemoUser(
  id: 'salvatore',
  name: 'Salvatore Giordano',
  image:
      'https://media.istockphoto.com/photos/millennial-male-team-leader-organize-virtual-workshop-with-employees-picture-id1300972574',
);

const userSacha = DemoUser(
  id: 'sacha',
  name: 'Sacha Arbonel',
  image:
      'https://media.istockphoto.com/photos/millennial-male-team-leader-organize-virtual-workshop-with-employees-picture-id1300972574',
);

const userDeven = DemoUser(
  id: 'deven',
  name: 'Deven Joshi',
  image:
      'https://media.istockphoto.com/photos/millennial-male-team-leader-organize-virtual-workshop-with-employees-picture-id1300972574',
);

const userSahil = DemoUser(
  id: 'sahil',
  name: 'Sahil Kumar',
  image:
      'https://media.istockphoto.com/photos/millennial-male-team-leader-organize-virtual-workshop-with-employees-picture-id1300972574',
);

const userReuben = DemoUser(
  id: 'reuben',
  name: 'Reuben Turner',
  image:
      'https://media.istockphoto.com/photos/millennial-male-team-leader-organize-virtual-workshop-with-employees-picture-id1300972574',
);

const userNash = DemoUser(
  id: 'nash',
  name: 'Nash Ramdial',
  image:
      'https://media.istockphoto.com/photos/millennial-male-team-leader-organize-virtual-workshop-with-employees-picture-id1300972574',
);

@immutable
class DemoUser {
  final String id;
  final String name;
  final String image;

  const DemoUser({
    required this.id,
    required this.name,
    required this.image,
  });
}
