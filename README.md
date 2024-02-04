#### Note :  This example only demonstrates minting from `Avalanche Fuji Testnet ------> Polygon Mumbai Testnet`, not the other way around


## Installation and Usage

```
git clone https://github.com/JustUzair/ccip-cross-chain-nft-minter.git
cd ccip-cross-chain-nft-minter
npm i
forge install
forge build
```

## Deployment and Usage

1. Deploy on source chain `SourceMinter.sol ` using `1_DeploySource.s.sol`
    - after deploying copy the address and fund the deployed contract using metamask
```bash 
forge script script/1_DeploySource.s.sol --rpc-url avalanche_fuji  --broadcast
```
- My Addresses after deployment on fuji testnet
    -    SourceMinter - `0x232B510Ea4105ed6B036677c82cfC65d9D209792`

2. Deploy to destination chain `DestinationMinter.sol` and `MyNFT.sol`
    - Deploy the script `2_DeployDestinationMinterAndNFT.s.sol` using the command below 
```bash
forge script script/2_DeployDestinationMinterAndNFT.s.sol --rpc-url mumbai  --broadcast
```
- My Addresses after deployment 
    - DestinationMinter - `0x9bF12fd7A1365bD6c551f39A2913F1BCaB5B5ef1`
    - MyNFT -  `0x4EA759589B46d2755f155f710fdDE7869B0E957D`

   
3. Mint NFT from source chain to destination chain
```bash
forge script script/3_MintNFtUsingSource.s.sol --rpc-url avalanche_fuji  --broadcast
```

4. After Above steps check with tx hash on [CCIP explorer](https://ccip.chain.link)
    - Here is my tx-hash for above steps : [Cross-Chain NFT Transfer](https://ccip.chain.link/msg/0xfeab8bddf6e85bf45580b6b64edb887e3025688b5f697a41f34c0926dc657414)
    - Here is the nft minted on mumbai from avalanche fuji : [Minted](https://mumbai.polygonscan.com/token/0x62fbdba31e2a3d1ee6d21f05ce39375ea4f4d523)



## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
