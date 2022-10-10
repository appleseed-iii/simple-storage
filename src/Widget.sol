// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "hitchens/HitchensUnorderedKeySet.sol";

contract Widget {

  using HitchensUnorderedKeySetLib for HitchensUnorderedKeySetLib.Set;
  HitchensUnorderedKeySetLib.Set widgetSet;

  struct WidgetStruct {
    string name;
    bool delux;
    uint price;
  }

  mapping(bytes32 => WidgetStruct) widgets;

  event LogNewWidget(address sender, bytes32 key, string name, bool delux, uint price);
  event LogUpdateWidget(address sender, bytes32 key, string name, bool delux, uint price);
  event LogRemWidget(address sender, bytes32 key);

  /// b32String=$(cast --format-bytes32-string "second")
  /// cast send --rpc-url=http://localhost:8545 --private-key=$PRIVATE_KEY $WIDGET_ADDR "newWidget(bytes32,string,bool,uint)" $b32String "some name" false 100
  function newWidget(bytes32 key, string memory name, bool delux, uint price) public {
    widgetSet.insert(key); // Note that this will fail automatically if the key already exists.
    WidgetStruct storage w = widgets[key];
    w.name = name;
    w.delux = delux;
    w.price = price;
    emit LogNewWidget(msg.sender, key, name, delux, price);
  }

  /// b32String=$(cast --format-bytes32-string "second")
  /// cast send --rpc-url=http://localhost:8545 --private-key=$PRIVATE_KEY $WIDGET_ADDR "updateWidget(bytes32,string,bool,uint)" $b32String "second one" true 10
  function updateWidget(bytes32 key, string memory name, bool delux, uint price) public {
    require(widgetSet.exists(key), "Can't update a widget that doesn't exist.");
    WidgetStruct storage w = widgets[key];
    w.name = name;
    w.delux = delux;
    w.price = price;
    emit LogUpdateWidget(msg.sender, key, name, delux, price);
  }

  function remWidget(bytes32 key) public {
    widgetSet.remove(key); // Note that this will fail automatically if the key doesn't exist
    delete widgets[key];
    emit LogRemWidget(msg.sender, key);
  }

  /// b32String=$(cast --format-bytes32-string "second")
  /// cast call --rpc-url=http://localhost:8545 $WIDGET_ADDR "getWidget(bytes32)(string,bool,uint)" $b32String
  function getWidget(bytes32 key) public view returns(string memory name, bool delux, uint price) {
    require(widgetSet.exists(key), "Can't get a widget that doesn't exist.");
    WidgetStruct storage w = widgets[key];
    return(w.name, w.delux, w.price);
  }

  /// cast call --rpc-url=http://localhost:8545 $WIDGET_ADDR "getWidgetCount()(uint)"
  function getWidgetCount() public view returns(uint count) {
    return widgetSet.count();
  }

  /// cast call --rpc-url=http://localhost:8545 $WIDGET_ADDR "getWidgetAtIndex(uint)(bytes32)" 0
  function getWidgetAtIndex(uint index) public view returns(bytes32 key) {
    return widgetSet.keyAtIndex(index);
  }
}