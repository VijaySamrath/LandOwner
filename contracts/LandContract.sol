// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.4;

contract LandContract {
    address owner;
    mapping (address => uint) public balances;

    struct Plot {
        address owner;
        bool forSale;
        uint price;

    }

    Plot[12] public plots;

    event PlotOwnerChanged(
        uint index
    );

    event PlotPriceChanged(
        uint index,
        uint price
    );

    event PlotAvailabilityChanges(
        uint index,
        uint price,
        bool forSale
    );

    constructor() {
        owner = msg.sender;
        plots[0].price = 4 ether;
        plots[0].forSale = true;
        plots[1].price = 4 ether;
        plots[1].forSale = true;
        plots[2].price = 4 ether;
        plots[2].forSale = true;
        plots[3].price = 4 ether;
        plots[3].forSale = true;
        plots[4].price = 4 ether;
        plots[4].forSale = true;
        plots[5].price = 4 ether;
        plots[5].forSale = true;
        plots[6].price = 4 ether;
        plots[6].forSale = true;
        plots[7].price = 4 ether;
        plots[7].forSale = true;
        plots[8].price = 4 ether;
        plots[8].forSale = true;
        plots[9].price = 4 ether;
        plots[9].forSale = true;
        plots[10].price = 4 ether;
        plots[10].forSale = true;
        plots[11].price = 4 ether;
        plots[11].forSale = true;

    }

    function putPlotUpForSale(uint index, uint price ) public {
        Plot storage plot = plots[index];
        require(msg.sender == plot.owner && price > 0);
        plot.forSale = true;
        plot.price = price;
        emit PlotAvailabilityChanges(index , price , true);

    }

    function takeOffMarket(uint index) public {
        Plot storage plot = plots[index];
        require(msg.sender == plot.owner);
        plot.forSale = false;
        emit PlotAvailabilityChanges(index, plot.price, false);


    }

    function getPlots() public view  returns(address[] memory, bool[] memory, uint[] memory) {
        address[] memory addrs = new address[](12);
        bool[] memory available  = new bool[](12);
        uint[] memory price = new uint[] (12);

        for (uint i = 0; i < 12; i++) {
            Plot storage plot = plots[i];
            addrs[i] = plot.owner;
            price[i] = plot.price;
            available[i] =plot.forSale;

        }
        return (addrs , available, price);

    }

    function buyPlot(uint index) public payable {
        Plot storage plot = plots[index];

        require(msg.sender != plot.owner && plot.forSale && msg.value >= plot.price);
        if(plot.owner == address(0*0) ){
            balances[plot.owner] += msg.value;

        } else {
            balances[plot.owner] += msg.value;

        }
        plot.owner = msg.sender;
        plot.forSale = false;

        emit PlotOwnerChanged(index);


    }

    function withdrawlFunds() public {
        address payee = msg.sender;
        uint payment = balances[payee];
        require(payment > 0);
        balances[payee] = 0;
        require(payable(msg.sender).send(payment));
    }

    function destroy() payable public {
        require(msg.sender == owner);
        selfdestruct(payable(owner));

    }








}


// 0x17f5ebBC5ad75b958F0eD7E66e498704c709A691 - contract address
