import 'package:flutter/widgets.dart';

class Fnodes {
  Map<String, FocusNode> nodesMap = {};
  BuildContext context;

  Fnodes({this.context});

  FocusNode getNode(String nodeName) {
    return nodesMap.putIfAbsent(nodeName, () => FocusNode(debugLabel: nodeName));
  }

  void disposeNode(String nodeName) {
    if (!nodesMap.containsKey(nodeName)) return;
    nodesMap[nodeName].dispose();
    nodesMap.remove(nodeName);
  }

  void transferFocus(String current, [String next]) {
    if (context == null) throw Exception('build context not found');
    if (!nodesMap.containsKey(current)) throw Exception('start node $current not found');
    nodesMap[current].unfocus();
    if (next == null) return;
    if (!nodesMap.containsKey(next)) throw Exception('destination node $next not found');
    FocusScope.of(context).requestFocus(nodesMap[next]);
  }

  void provideContext(BuildContext context) {
    this.context = context;
  }

  void removeFocus() {
    nodesMap.forEach((_, node) => node.unfocus());
  }

  void dispose() {
    nodesMap.forEach((_, node) => node.dispose());
    nodesMap.clear();
  }

  void clear() {
    // nodesMap.forEach((_, node) => node.dispose());
    nodesMap.clear();
  }
}