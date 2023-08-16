pragma solidity ^0.4.17;

contract ClonadorNFT {

  address public owner;
  mapping(string => string) public clones;

  constructor() public {
    owner = msg.sender;
  }

  function clone(string memory _tokenIdOriginal) public {

    require(msg.sender == owner, "Solo el propietario puede clonar");

    string memory _tokenIdOriginal = "1099512959271"; //Token original Alien.worlds
    string memory templateID = "#19465"; 

    string memory newTokenId = keccak256(abi.encodePacked(_tokenIdOriginal, clones.length));

     ChildChain.NFT nft = new ChildChain.NFT("Alien.worlds", templateID, newTokenId);

     nft.setOwner("mr5xo.wam"); //Insertar nueva cuenta como propietario  

     nft.setProperties("Datos del clon", "etc");

     nft.issue();

 	    clones[_tokenIdOriginal] = newTokenId;
  }

  function transferClone(string memory _tokenIdOriginal, address _newOwner) public {

    require(clones[_tokenIdOriginal] != "", "Clon no existe");

     ChildChain.NFT nft = ChildChain.NFT.getNFT(clones[_tokenIdOriginal]);
  
     nft.setOwner(_newOwner);  
     nft.transfer(); //Transferir propiedad del clon  

   }

}
