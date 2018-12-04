pragma solidity ^0.4.24; 

import './ERC721.sol';

contract ERC721Token is ERC721 {
	mapping(uint256 => address) tokenToOwner; 
	mapping(address => uint256) ownerToBalance; 
	mapping(uint256 => address) tokenToApproved;
	mapping(address => mapping(address => bool)) ownerToOperator;

	modifier hasPermission(address _caller, uint256 _tokenId) {
		require(_caller == tokenToOwner[_tokenId]
		|| getApproved(_tokenId) == _caller
		|| isApprovedForAll(tokenToOwner[_tokenId], _caller));
		_;
	}
	//	mint()
	function mint(uint256 _tokenId) public {
		//	Add your logic here and at the end:
		require(tokenToOwner[_tokenId] == address(0), "this token belongs to someone else already");
		tokenToOwner[_tokenId] = msg.sender; 
		ownerToBalance[msg.sender] += 1;
		emit Transfer(address(0), msg.sender, _tokenId);
	}
	//	approve()
	//
	//	@notice Change or reaffirm the approved address for an NFT
	//	@dev The zero address indicates there is no approved address.
	//		Throws unless `msg.sender` is the current NFT owner, or an authorized
	//		operator of the current owner.
	//	@param _approved The new approved NFT controller
	//	@param _tokenId The NFT to approve
	function approve(address _approved, uint256 _tokenId) external payable {
		//	Add your logic here
		require(tokenToOwner[_tokenId] == msg.sender);
		tokenToApproved[_tokenId] = _approved;
		emit Approval(msg.sender, _approved, _tokenId);
	}
	//	setApprovalForAll()
	//
	//	@notice Enable or disable approval for a third party ("operator") to manage
	//		all of `msg.sender`'s assets
	//	@dev Emits the ApprovalForAll event. The contract MUST allow
	//	multiple operators per owner.
	//	@param _operator Address to add to the set of authorized operators
	//	@param _approved True if the operator is approved, false to revoke approval
	function setApprovalForAll(address _operator, bool _approved) external {
		//	Add your logic here
		ownerToOperator[msg.sender][_operator] = _approved;
		emit ApprovalForAll(msg.sender, _operator, _approved);
	}
	//	getApproved()
	//
	//	@notice Get the approved address for a single NFT
	//	@dev Throws if `_tokenId` is not a valid NFT.
	//	@param _tokenId The NFT to find the approved address for
	//	@return The approved address for this NFT, or the zero address if there is none
	function getApproved(uint256 _tokenId) public view returns (address) {
		//	Add your logic here
		return tokenToApproved[_tokenId];
	}
	//	isApprovedForAll()
	//
	//	@notice Query if an address is an authorized operator for another address
	//	@param _owner The address that owns the NFTs
	//	@param _operator The address that acts on behalf of the owner
	//	@return True if `_operator` is an approved operator for `_owner`, false otherwise
	function isApprovedForAll(address _owner, address _operator) public view returns (bool) {
		//	Add your logic here
		return ownerToOperator[_owner][_operator];
	}
	//	ownerOf()
	//
	//	@notice Find the owner of an NFT
	//	@dev NFTs assigned to zero address are considered invalid, and queries
	//		about them do throw.
	//	@param _tokenId The identifier for an NFT
	//	@return The address of the owner of the NFT
	function ownerOf(uint256 _tokenId) external view returns (address) {
		return tokenToOwner[_tokenId];
	}
	//	transferFrom() with helper
	//
	//	@notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
	//		TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
	//		THEY MAY BE PERMANENTLY LOST
	//	@dev Throws unless `msg.sender` is the current owner, an authorized
	//		operator, or the approved address for this NFT. Throws if `_from` is
	//		not the current owner. Throws if `_to` is the zero address. Throws if
	//		`_tokenId` is not a valid NFT.
	//	@param _from The current owner of the NFT
	//	@param _to The new owner
	//	@param _tokenId The NFT to transfer
	function transferFrom(address _from, address _to, uint256 _tokenId) external payable hasPermission(msg.sender, _tokenId) {
		transferFromHelper(_from, _to, _tokenId);
	}
	function transferFromHelper(address _from, address _to, uint256 _tokenId) internal {
		tokenToOwner[_tokenId] = _to; 
		ownerToBalance[_from] -= 1;
		emit Transfer(_from, _to, _tokenId);
	}
}