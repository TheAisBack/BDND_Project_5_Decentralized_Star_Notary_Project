pragma solidity ^0.4.23;

import './ERC721Token.sol';

contract StarNotary is ERC721Token {
	struct Star {
		string name;
	}
	mapping(uint256 => Star) public tokenIdToStarInfo;
	mapping(uint256 => uint256) public starsForSale;
	//	createStar()
	function createStar(string _name, string _starStory, string _ra, string _dec, string _mag, uint256 _tokenId) public {
		//	Create a `Star memory newStar` variable
		//	Verify uniquenessFactor `keccak256(_ra, _dec, _mag)`
		Star memory newStar = Star(_name);
		tokenIdToStarInfo[_tokenId] = newStar;
		ERC721Token.mint(_tokenId);
	}
	//	putStarUpForSale()
	function putStarUpForSale(uint256 _tokenId, uint256 _price) public {
		//	`require` owner in the token is equal to `msg.sender`
		require(this.ownerOf(_tokenId) == msg.sender);
		starsForSale[_tokenId] = _price;
	}
	//	buyStar()
	function buyStar(uint256 _tokenId) public payable {
		//	Verify if the star is for sale
		//	Verify you have amount
		require(starsForSale[_tokenId] > 0);
		uint256 starCost = starsForSale[_tokenId];
		address starOwner = this.ownerOf(_tokenId);
		require(msg.value >= starCost);
		clearPreviousStarState(_tokenId);
		transferFromHelper(starOwner, msg.sender, _tokenId);
		//	If everything is okay transfer
		if(msg.value > starCost) {
			msg.sender.transfer(msg.value - starCost);
		}
		starOwner.transfer(starCost);
	}
	function clearPreviousStarState(uint256 _tokenId) private {
		//	clear approvals 
		tokenToApproved[_tokenId] = address(0);
		//	clear being on sale 
		starsForSale[_tokenId] = 0;
	}
}