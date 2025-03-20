# Flow UFC NFTs

This is a project that will migrate UFC NFTs from Flow to Aptos

## Account Setup

### Creating a Flow Testnet Account

1. Install [Flow CLI](https://developers.flow.com/tools/flow-cli/install)

2. Create a new Flow testnet account:
   ```
   flow accounts create --network=testnet
   ```

3. Fund your testnet account:
   - Go to the Flow Faucet: https://testnet-faucet.onflow.org/
   - Enter your testnet account address
   - Click "Fund Account" to receive free test FLOW tokens

4. Configure your account in `flow.json`:
   ```
   flow config add account <account-name> --network=testnet --address <account-address> --key <account-private-key>
   ```

### Running the NFTs flow

1. Run `setup_collection` signing with the receiver's address to create a collection on the receiver's account.

   ```
   flow transactions send cadence/transactions/setup_collection.cdc \
     --signer <receiver_account> \   
     --network testnet
   ```

2. (if necessary) Run `create_series` signing with the NFT owner's account
  
   ```
   flow transactions send cadence/transactions/create_series.cdc 1 \
     --signer <contract_owner_account> \
     --network testnet 
   ```
   
3. (if necessary) Run `create_set` signing with the NFT owner's account

   ```
   flow transactions send cadence/transactions/create_set.cdc 1 1 \
     --signer <contract_owner_account> \
     --network testnet
   ```

4. Mint an NFT using either admin minting or public minting:

   **Admin Minting** (requires contract owner privileges):
   ```
   flow transactions send cadence/transactions/mint_nft.cdc <receiver_address> 1 1 1 \
     --signer <contract_owner_account> \
     --network testnet
   ```

   **Public Minting** (can be signed by any account):
   ```
   flow transactions send cadence/transactions/public_mint_nft.cdc <receiver_address> 1 1 1 \
     --signer <any_account> \
     --network testnet
   ```

5. You can check collections, series, sets and NFTs with the check scripts:
   ```
   flow scripts execute cadence/scripts/check_series.cdc 1 --network=testnet
   flow scripts execute cadence/scripts/check_sets.cdc 1 --network=testnet
   flow scripts execute cadence/scripts/check_collection.cdc <account_address> --network=testnet
   ```

## Updating Metadata

The UFC_NFT contract stores metadata at the Set level. To update metadata for NFTs:

1. For unsealed series, use the existing update function:
   ```
   flow transactions send cadence/transactions/update_set_metadata.cdc <series_id> <set_id> <max_editions> <metadata> \
     --signer <contract_owner_account> \
     --network testnet
   ```

2. For specific NFT queries:
   ```
   flow scripts execute cadence/scripts/get_nft_metadata.cdc <account_address> <token_id> --network=testnet
   ```

### Useful Links

- [Flow UFC contract Mainnet](https://www.flowscan.io/contract/A.329feb3ab062d289.UFC_NFT?tab=deployments)
- [Flow Language, Cadence](https://cadence-lang.org/)
- [Flow Playground](https://play.flow.com/)
- [Testnet Faucet](https://faucet.flow.com/fund-account)
- [Testnet Explorer](https://testnet.flowscan.io/)
- [More block explorers](https://developers.flow.com/ecosystem/block-explorers)
- [Flow Core Smart Contracts (to import)](https://developers.flow.com/build/core-contracts)
- [Contracts Updatability](https://cadence-lang.org/docs/language/contract-updatability)


---

## 👋 Welcome Flow Developer!

This project is a starting point for you to develop smart contracts on the Flow Blockchain. It comes with example contracts, scripts, transactions, and tests to help you get started.

## 🔨 Getting Started

Here are some essential resources to help you hit the ground running:

- **[Flow Documentation](https://developers.flow.com/)** - The official Flow Documentation is a great starting point to start learning about about [building](https://developers.flow.com/build/flow) on Flow.
- **[Cadence Documentation](https://cadence-lang.org/docs/language)** - Cadence is the native language for the Flow Blockchain. It is a resource-oriented programming language that is designed for developing smart contracts.  The documentation is a great place to start learning about the language.
- **[Visual Studio Code](https://code.visualstudio.com/)** and the **[Cadence Extension](https://marketplace.visualstudio.com/items?itemName=onflow.cadence)** - It is recommended to use the Visual Studio Code IDE with the Cadence extension installed.  This will provide syntax highlighting, code completion, and other features to support Cadence development.
- **[Flow Clients](https://developers.flow.com/tools/clients)** - There are clients available in multiple languages to interact with the Flow Blockchain.  You can use these clients to interact with your smart contracts, run transactions, and query data from the network.
- **[Block Explorers](https://developers.flow.com/ecosystem/block-explorers)** - Block explorers are tools that allow you to explore on-chain data.  You can use them to view transactions, accounts, events, and other information.  [Flowser](https://flowser.dev/) is a powerful block explorer for local development on the Flow Emulator.

## 📦 Project Structure

Your project has been set up with the following structure:

- `flow.json` - This is the configuration file for your project (analogous to a `package.json` file for NPM).  It has been initialized with a basic configuration and your selected Core Contract dependencies to get started.

  Your project has also been configured with the following dependencies.  You can add more dependencies using the `flow deps add` command:
    - `NonFungibleToken`
    - `ViewResolver`

- `/cadence` - This is where your Cadence smart contracts code lives

Inside the `cadence` folder you will find:
- `/contracts` - This folder contains your Cadence contracts (these are deployed to the network and contain the business logic for your application)
  - `UFC_NFT.cdc`
- `/scripts` - This folder contains your Cadence scripts (read-only operations)
  - Various scripts to check NFTs, collections, etc.
- `/transactions` - This folder contains your Cadence transactions (state-changing operations)
  - Transactions for minting NFTs, creating series and sets, etc.
- `/tests` - This folder contains your Cadence tests (integration tests for your contracts, scripts, and transactions to verify they behave as expected)

## Running the Existing Project

To learn more about using the CLI, check out the [Flow CLI Documentation](https://developers.flow.com/tools/flow-cli).

## 👨‍💻 Start Developing

### Creating a New Contract

To add a new contract to your project, run the following command:

```shell
flow generate contract
```

This command will create a new contract file and add it to the `flow.json` configuration file.

### Creating a New Script

To add a new script to your project, run the following command:

```shell
flow generate script
```

This command will create a new script file.  Scripts are used to read data from the blockchain and do not modify state (i.e. get the current balance of an account, get a user's NFTs, etc).

You can import any of your own contracts or installed dependencies in your script file using the `import` keyword.  For example:

```cadence
import "UFC_NFT"
```

### Creating a New Transaction

To add a new transaction to your project you can use the following command:

```shell
flow generate transaction
```

This command will create a new transaction file.  Transactions are used to modify the state of the blockchain (i.e purchase an NFT, transfer tokens, etc).

You can import any dependencies as you would in a script file.

### Creating a New Test

To add a new test to your project you can use the following command:

```shell
flow generate test
```

This command will create a new test file.  Tests are used to verify that your contracts, scripts, and transactions are working as expected.

### Installing External Dependencies

If you want to use external contract dependencies (such as NonFungibleToken, FlowToken, FungibleToken, etc.) you can install them using [Flow CLI Dependency Manager](https://developers.flow.com/tools/flow-cli/dependency-manager).

For example, to install the NonFungibleToken contract you can use the following command:

```shell
flow deps add mainnet://1d7e57aa55817448.NonFungibleToken
```

Contracts can be found using [ContractBrowser](https://contractbrowser.com/), but be sure to verify the authenticity before using third-party contracts in your project.

## 🧪 Testing

To verify that your project is working as expected you can run the tests using the following command:

```shell
flow test
```

This command will run all tests with the `_test.cdc` suffix (these can be found in the `cadence/tests` folder). You can add more tests here using the `flow generate test` command (or by creating them manually).

To learn more about testing in Cadence, check out the [Cadence Test Framework Documentation](https://cadence-lang.org/docs/testing-framework).

## 🚀 Deploying Your Project

To deploy your project to the Flow network, you must first have a Flow account and have configured your deployment targets in the `flow.json` configuration file.

You can create a new Flow account using the following command:

```shell
flow accounts create
```

Learn more about setting up deployment targets in the [Flow CLI documentation](https://developers.flow.com/tools/flow-cli/deployment/project-contracts).

### Deploying to the Flow Emulator

To deploy your project to the Flow Emulator, start the emulator using the following command:

```shell
flow emulator --start
```

To deploy your project, run the following command:

```shell
flow project deploy --network=emulator
```

This command will start the Flow Emulator and deploy your project to it. You can now interact with your project using the Flow CLI or alternate [client](https://developers.flow.com/tools/clients).

### Deploying to Flow Testnet

To deploy your project to Flow Testnet you can use the following command:

```shell
flow project deploy --network=testnet
```

This command will deploy your project to Flow Testnet. You can now interact with your project on this network using the Flow CLI or any other Flow client.

### Deploying to Flow Mainnet

To deploy your project to Flow Mainnet you can use the following command:

```shell
flow project deploy --network=mainnet
```

This command will deploy your project to Flow Mainnet. You can now interact with your project using the Flow CLI or alternate [client](https://developers.flow.com/tools/clients).

## 📚 Other Resources

- [Cadence Design Patterns](https://cadence-lang.org/docs/design-patterns)
- [Cadence Anti-Patterns](https://cadence-lang.org/docs/anti-patterns)
- [Flow Core Contracts](https://developers.flow.com/build/core-contracts)

## 🤝 Community
- [Flow Community Forum](https://forum.flow.com/)
- [Flow Discord](https://discord.gg/flow)
- [Flow Twitter](https://x.com/flow_blockchain)
