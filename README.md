# Build a Private Blockchain Notary Service

The last project for Term 1 of Udacity's Blockchain Developer Nanodegree

## Instructions
- Starter code is available at

<a href="https://s3.amazonaws.com/video.udacity-data.com/topher/2019/January/5c51c4c0_project-5-starter-code/project-5-starter-code.zip">Download here the Starter Code</a>

- Open the package-lock.json and verify that `truffle-hdwallet-provider` and `openzeppelin-solidity` dependencies are installed. If not you can always install it with the commands:

`npm install --save truffle-hdwallet-provider`

`npm install --save openzeppelin-solidity`

- For starting the development console, run:

`truffle develop`

- For compiling the contract, inside the development console, run:

`compile`

- For migrating the contract to the locally running Ethereum network, inside the development console, run:

`migrate --reset`

- For running unit tests the contract, inside the development console, run:

`test`

- For running the Front End of the DAPP, open another terminal window and go inside the project directory, and run:

`cd app`

`npm run dev`

## Project 5 Tasks

### Task 1

Your Project is to Modify the StarNotary version 2 contract code to achieve the following:

- Add a name and a symbol for your starNotary tokens. Resource
- Add a function lookUptokenIdToStarInfo, that looks up the stars using the Token ID, and then returns the name of the star.
- Add a function called exchangeStars, so 2 users can exchange their star tokens...Do not worry about the price, just write code to exchange stars between users.
- Write a function to Transfer a Star. The function should transfer a star from the address of the caller. The function should accept 2 arguments, the address to transfer the star to, and the token ID of the star.

### Task 2

Add supporting unit tests, to test the following:

- The token name and token symbol are added properly.
- 2 users can exchange their stars.
- Stars Tokens can be transferred from one address to another.

### Task 3

Deploy your Contract to Rinkeby

- Edit the truffle.config file to add settings to deploy your contract to the Rinkeby Public Network.

Helper Points:

- Command used to deploy to Rinkeby `truffle migrate --reset --network rinkeby`
- You will need to have your Metamask’s seed and Infura setup.
- This was shown to you in detail in the lesson on Solidity, while creating ERC-20 tokens on Rinkeby.

### Task 4

Modify the front end of the DAPP to achieve the following:

- Lookup a star by ID using tokenIdToStarInfo() (you will have to add code for this in your index.html and index.js files)

### BlockChain Information

1) ERC-721 Token Name

2) ERC-721 Token Symbol

3) Version of the Truffle and OpenZeppelin Used
