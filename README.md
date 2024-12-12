# Cadence Cookbook Recipe: Withdrawing Tokens

### What is this recipe about?

This is included in your smart contract when you would like to implement token withdrawls. Also useful for transferring tokens between accounts.

## Table of Contents

- [Description](#description)
- [What is included in this repository?](#what-is-included-in-this-repository)
- [Supported Recipe Data](#recipe-data)
- [Deploying Recipe Contracts and Running Transactions Locally (Flow Emulator)](#deploying-recipe-contracts-and-running-transactions-locally-flow-emulator)
- [License](#license)

## Description

### What is the Cadence Cookbook?

The Cadence Cookbook is a collection of code examples, recipes, and tutorials designed to help developers learn and understand the Cadence programming language. Cadence is the smart contract programming language used on the Flow blockchain. Whether you are new to Flow or an experienced blockchain developer, the Cadence Cookbook serves as a valuable resource to explore various aspects of Cadence and its applications in building dApps on the Flow blockchain.

Each recipe in the Cadence Cookbook is a practical coding example that showcases a specific aspect of Cadence or use-case on Flow, including smart contract development, interaction, and best practices. By following these recipes, you can gain hands-on experience and learn how to leverage Cadence for your blockchain projects.

### Contributing to the Cadence Cookbook

Learn more about the contribution process [here](https://github.com/onflow/cadence-cookbook/blob/main/contribute.md).

## What is included in this repository?

Each recipe repository is subdivided into 2 main sections, Cadence code files (.cdc) under the `/cadence` directory, and explanation files (.txt) under the `/explanations` directory.

The Cadence Cookbook supports Cadence code and explanations for the contract, transaction, and testing elements of each recipe.

Recipe metadata, such as title, author, and category labels, is stored in `index.js`. Each recipe also includes a link to a live, runnable example of the corresponding code in the [Flow Playground](https://play.flow.com).

```
recipe-name/
├── cadence/                          # Cadence files for recipe examples
│   ├── contracts/Recipe.cdc          # Contract code
│   ├── transactions/withdraw_token.cdc   # Transaction code
│   ├── tests/Recipe_test.cdc           # Tests code
├── explanations/           # Explanation files for recipe examples
│   ├── contract.txt        # Contract code explanation
│   ├── transaction.txt     # Transaction code explanation
│   ├── tests.txt           # Tests code explanation
├── index.js                # Root file for storing recipe metadata
├── README.md               # This README file
└── LICENSE                 # License information
```

## Supported Recipe Data

- `const recipe`: defines a unique identifier (slug) for the recipe
- `title`: indicates the title of the recipe
- `featuredText`(optional): a subheading for the recipe title
- `coverUrl` (optional): path to a featured cover image for the recipe
- `createdAt`: date on which recipe was added to the Cadence Cookbook
- `author`: contributor of the recipe
- `playgroundLink`: a link to Flow Playground containing the deployed recipe code
- `excerpt`: a brief description of the recipe contents
- `smartContractCode`: path to location of Cadence smart contract code example
- `smartContractExplanation`: path to location of smart contract code explanation
- `transactionCode`: path to location of Cadence transaction code example
- `transactionExplanation`: path to location of transaction code explanation
- `testsPath`: path to location of Cadence test cases code example
- `testsExplanationPath`: path to location of test cases code explanation
- `filters`: the filters object is used to perform filtering on recipes in the cookbook
    - `difficulty`: the difficulty filter supports one of ['beginner', 'intermediate', 'advanced']


```
// Pass the repo name
const recipe = "sample-recipe-name";

//Generate paths of each code file to render
const contractPath = `${recipe}/cadence/contract.cdc`;
const transactionPath = `${recipe}/cadence/transaction.cdc`;
const testsPath = `${recipe}/cadence/tests.cdc`;

//Generate paths of each explanation file to render
const smartContractExplanationPath = `${recipe}/explanations/contract.txt`;
const transactionExplanationPath = `${recipe}/explanations/transaction.txt`;
const testsExplanationPath = `${recipe}/explanations/tests.txt`;

export const sampleRecipe= {
  slug: recipe,
  title: "",
  featuredText: "",
  createdAt: Date(2022, 3, 1),
  author: "",
  playgroundLink: "",
  excerpt: "",
  smartContractCode: contractPath,
  smartContractExplanation: smartContractExplanationPath,
  transactionCode: transactionPath,
  transactionExplanation: transactionExplanationPath,
};
```
## Deploying Recipe Contracts and Running Transactions Locally (Flow Emulator)

This section explains how to deploy the recipe's contracts to the Flow emulator, run the associated transaction with sample arguments, and verify the results.

### Prerequisites

Before deploying and running the recipe:

1. Install the Flow CLI. You can find installation instructions [here](https://docs.onflow.org/flow-cli/install/).
2. Ensure the Flow emulator is installed and ready to use with `flow version`.

### Step 1: Start the Flow Emulator

Start the Flow emulator to simulate the blockchain environment locally

```bash
flow emulator start
```

### Step 2: Install Dependencies and Deploy Project Contracts

Deploy contracts to the emulator. This will deploy all the contracts specified in the _deployments_ section of `flow.json` whether project contracts or dependencies.

```bash
flow dependencies install
flow project deploy --network=emulator                                  
```

### Step 3: Run the Transaction

Transactions associated with the recipe are located in `./cadence/transactions`. To run a transaction, execute the following command:

```bash
flow transactions send cadence/transactions/TRANSACTION_NAME.cdc --signer emulator-account
```

To verify the transaction's execution, check the emulator logs printed during the transaction for confirmation messages. You can add the `--log-level debug` flag to your Flow CLI command for more detailed output during contract deployment or transaction execution.

## License

This repository is licensed under the [MIT License](LICENSE).