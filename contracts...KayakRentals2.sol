//Jayde Magee and Avrie White
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0; 

//1. Designate License & Solidity Version
contract KayakRental {

//2. Designate Contract Owner 
address payable public owner; 
address public seller;
bool public available; 
uint public ratePerDay;
//3. Define at Least Two Other Appropriate State Variables

//7. Create One Event for the Smart Contract
event Log(address indexed sender, string message); 
//4. Set Appropriate Initial Conditions Via Constructor Method
constructor() {
        owner = payable(msg.sender);
        seller = tx.origin;
        available = true; 
        ratePerDay = 3 ether;
    }
//6. 1/2 Modifiers
modifier onlyOwner(){
require(msg.sender == owner, "Must be contract owner to call this function");
_;
    }
//6. 2/2 Modifiers
modifier onlySeller() { 
require(tx.origin == seller, "Only seller can call this.");
_;
    }
//5. 1/3 Public Functions
function updateRate(uint newRate) public onlySeller {
    ratePerDay == newRate;
emit Log(msg.sender, "Owner updated kayak rental rate.");
}
//5. 2/3 Public Functions
function makeKayakAvailable() public onlyOwner {
    available = true; 
emit Log(msg.sender, "Be more Kayaky.");
}
//5. 3/3 Public Functions
function bookKayak(uint numDays) public payable {
require(available, "Kayak is not available.");
uint minOffer = ratePerDay * numDays; 
require(msg.value >= minOffer, "Not enough ether provided." );
    (bool sent, bytes memory data) = owner.call{value: msg.value}("");
if (sent) {available= false;}
    available = false;
emit Log(msg.sender, "Kayak was booked.");
}
}