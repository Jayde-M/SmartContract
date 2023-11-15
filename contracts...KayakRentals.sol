pragma solidity >=0.8.0 <0.9.0;

contract KayakRental {

address payable public owner;
    bool public available;
    uint public ratePerDay;
    bool public isDamaged;

    event Log(address indexed sender, string message);

    constructor() {
        owner = payable(msg.sender);
        available = true;
        ratePerDay = 2 ether; //CUSTOMIZE
}
 modifier onlyOwner() {
        require(msg.sender == owner, "Must be contract owner to call this function");
        _;
    }
    function bookKayak(uint numDays) public payable {
        // Check availability
        require(available, "Kayak is not available.");
        // Check payment amount
        uint minOffer = ratePerDay * numDays;
        require(msg.value >= minOffer, "Not enough ether provided.");

        // Recieve payment
        // owner.transfer(msg.value);
        (bool sent, bytes memory data) = owner.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
        
        available = false;
        emit Log(msg.sender, "Kayak has been booked.");
        // available = false;
        }
modifier onlyIfNotDamaged() {
    require(!isDamaged, "The kayak is damaged and cannot be rented");
    _;
}
    function reportDamage() external onlyOwner {
        isDamaged = true;
        
    }

         function updateRate(uint newRate) public onlyOwner {
        // require(msg.sender == owner, "Only the contract owner can change the rate.");
        ratePerDay = newRate;
        emit Log(msg.sender, "Owner updated kayak rate.");
    }
        function makeYachtAvailable() public onlyOwner {
        // require(msg.sender == owner, "Only the yacht owner can make it available.");
        available = true;
        emit Log(msg.sender, "Have some fun. Rent my Kayak.");
    }

        function checkDamaged() external view onlyOwner returns (bool) {
        return isDamaged;
    }

}