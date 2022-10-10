// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Widget.sol";

contract WidgetTest is Test {
    Widget public widgetContract;
    bytes public err;

    function setUp() public {
        widgetContract = new Widget();
        // new Widget
        bytes32 newKey = "1";
        widgetContract.newWidget(newKey, "name", false, 100);
        assertEq(widgetContract.getWidgetCount(), 1);
    }

    function testWidgetCount() public {
        uint initialCount = widgetContract.getWidgetCount();
        assertEq(initialCount, 1);
    }

    function testGetWidget() public {
        // existing Widget
        bytes32 existingKey = "1";
        (string memory name, bool delux, uint price) = widgetContract.getWidget(existingKey);
        assertEq(name, "name");
        assertEq(delux, false);
        assertEq(price, 100);
    }

    function testCannotCreateDuplicateKey() public {
        vm.expectRevert("UnorderedKeySet(101) - Key already exists in the set.");
        // duplicate Key
        bytes32 newKey = "1";
        widgetContract.newWidget(newKey, "name", false, 100);
    }

    function testNewWidget() public {
        // new Widget
        bytes32 newKey = "2";
        widgetContract.newWidget(newKey, "second", true, 1000);
        assertEq(widgetContract.getWidgetCount(), 2);
    }

    function testUpdateWidget() public {
        // existing Widget
        bytes32 existingKey = "1";
        widgetContract.updateWidget(existingKey, "new name", true, 101);
        (string memory name, bool delux, uint price) = widgetContract.getWidget(existingKey);
        assertEq(name, "new name");
        assertEq(delux, true);
        assertEq(price, 101);
    }

    function testRemoveWidget() public {
        uint existingCount = widgetContract.getWidgetCount();
        // existing Widget
        bytes32 existingKey = "1";
        widgetContract.remWidget(existingKey);
        assertEq(widgetContract.getWidgetCount(), existingCount - 1);
    }
}
