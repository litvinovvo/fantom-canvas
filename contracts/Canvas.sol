// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Canvas {
    address _owner;
    
    uint drawCost = 0.05 ether;
    uint colorCost = 10 ether;
    
    modifier onlyOwner() {
        require(msg.sender == _owner);
        _;
    }
    
    uint8[100][100] canvas;
    uint8[3][] palette;
    
    constructor() {
        _owner = msg.sender;
        
        _addColor([255,255,255]); // color 0 is white for initial background
        _addColor([0,0,0]);
        _addColor([255,0,0]);
        _addColor([0,255,0]);
        _addColor([0,0,255]);
    }
    
    function addColor(uint8[3] memory color) public payable {
        if (msg.sender != _owner) {
            require(msg.value == colorCost);
        }
        _addColor(color);
    }
    
    function setColorCost(uint cost) public onlyOwner {
        colorCost = cost;
    }
    
    function setDrawCost(uint cost) public onlyOwner {
        drawCost = cost;
    }
    
    function _addColor(uint8[3] memory color) private {
        palette.push(color);
    }
    
    function draw(uint8[] memory _x, uint8[] memory _y, uint8[] memory _c) public payable {
        require(_x.length == _y.length);
        require(_x.length == _c.length);
        require(msg.value == _x.length*drawCost);

        for (uint i = 0; i < _x.length; i++) {
            require(_c[i] < palette.length);
            require(_x[i] < _x.length);
            require(_y[i] < _y.length);
            
            canvas[_x[i]][_y[i]] = _c[i];
        }
    }
    
    function getPalette() view public returns(uint8[3][] memory) {
        return palette;
    }
    
    function getCanvas() view public returns(uint8[100][100] memory) {
        return canvas;
    }

    function getOwner() view public returns(address) {
        return _owner;
    }
}