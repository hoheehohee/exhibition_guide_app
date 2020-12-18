import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';

List<MenuItem> items = [
  new MenuItem<int>(
    id: 0,
    title: '전시유물',
    icon: Icons.bookmark,
  ),
  new MenuItem<int>(
    id: 1,
    title: '상설전지',
    icon: Icons.bookmark,
  ),
  new MenuItem<int>(
    id: 2,
    title: '전시관 지도',
    icon: Icons.bookmark,
  ),
  new MenuItem<int>(
    id: 3,
    title: '오시는길',
    icon: Icons.bookmark,
  ),
  new MenuItem<int>(
    id: 4,
    title: '공지사항',
    icon: Icons.bookmark,
  ),
  new MenuItem<int>(
    id: 5,
    title: '이용설정',
    icon: Icons.bookmark,
  ),
  new MenuItem<int>(
    id: 6,
    title: '이용예약 신청',
    icon: Icons.bookmark,
  ),
  new MenuItem<int>(
    id: 7,
    title: '마이페이지',
    icon: Icons.bookmark,
  ),
];
final menu = Menu(
  items: items.map((e) => e.copyWith(icon: null)).toList(),
);

final menuWithIcon = Menu(
  items: items,
);