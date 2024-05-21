// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {DecentralizedStableCoin} from "../../src/DecentralizedStableCoin.sol";

contract DecentralizedStableCoinTest is Test {
    DecentralizedStableCoin dsc;

    function setUp() public {
        dsc = new DecentralizedStableCoin();
    }

    // MintMustBeMoreThanZero - Done
    // BurnMustBeMoreThanZero - Done
    // CantMintToZeroAddress - Done
    // CantBurnToZeroAddress - Done
    // DSC contract simple, only contain to functions within each both Burn and Mint
    // expect revert placed above line that will fail.

    function testBurnMustBeMoreThanZero() public {
        vm.startPrank(dsc.owner());
        dsc.mint(address(this), 100);
        vm.expectRevert();
        dsc.burn(0);
        vm.stopPrank;
    }

    function testMintMustBeMoreThanZero() public {
        vm.startPrank(dsc.owner());
        vm.expectRevert();
        dsc.mint(address(this), 0);
    }

    function testCantBurnMoreThanYouHave() public {
        vm.startPrank(dsc.owner());
        dsc.mint(address(this), 100);
        vm.expectRevert();
        dsc.burn(102);
        vm.stopPrank();
    }

    function testCantMintToZeroAddress() public {
        vm.startPrank(dsc.owner());
        vm.expectRevert();
        dsc.mint(address(0), 100);
        vm.stopPrank();
    }
}
