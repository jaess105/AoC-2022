import 'package:quiver/collection.dart';
import 'package:quiver/core.dart';

abstract class Node {
  String get name;
  int get size;
  AbstractDir get parent;
}

abstract class AbstractDir implements Node {
  final String _name;
  final List<Node> _children = [];

  AbstractDir(this._name);

  @override
  String get name => _name;

  @override
  int get size =>
      _children.map((e) => e.size).fold(0, (prev, newVal) => prev + newVal);

  @override
  List<Node> get children => _children;

  @override
  AbstractDir getChildWithName(String name) {
    return _children.firstWhere((element) {
      if (element is Dir) {
        return element._name == name;
      }
      return false;
    }) as AbstractDir;
  }

  @override
  void addChild(Node child) => _children.add(child);
  @override
  void addChildren(Iterable<Node> children) => _children.addAll(children);

  @override
  String toString() {
    return "{Dir: (\nname: '$_name', \n'[${_children.join('\n')}]' ,'\n$size')}";
  }

  @override
  bool operator ==(Object other) =>
      other is AbstractDir &&
      other.runtimeType == runtimeType &&
      other._name == _name &&
      listsEqual(other._children, _children);

  @override
  int get hashCode => hash2(_name.hashCode, _children.hashCode);
}

class Root extends AbstractDir {
  Root() : super("/");

  @override
  AbstractDir get parent => this;
}

class Dir extends AbstractDir {
  final AbstractDir _parent;

  Dir(name, this._parent) : super(name);

  AbstractDir get parent => _parent;

  @override
  String get name => _name;
}

class File implements Node {
  final String _name;
  final AbstractDir _parent;
  final int _size;

  File(this._name, this._parent, this._size);

  @override
  String get name => _name;

  @override
  int get size => _size;

  @override
  AbstractDir get parent => _parent;

  @override
  bool operator ==(Object other) =>
      other is File &&
      other.runtimeType == runtimeType &&
      other._name == _name &&
      other._size == _size;

  @override
  int get hashCode => hash2(_name.hashCode, _size.hashCode);

  @override
  String toString() {
    return "{File: (name: '$_name', $_size)}";
  }
}