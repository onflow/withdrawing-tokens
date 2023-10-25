// Pass the repo name
const recipe = "withdrawing-tokens";

//Generate paths of each code file to render
const contractPath = `${recipe}/cadence/contract.cdc`;
const transactionPath = `${recipe}/cadence/transaction.cdc`;

//Generate paths of each explanation file to render
const smartContractExplanationPath = `${recipe}/explanations/contract.txt`;
const transactionExplanationPath = `${recipe}/explanations/transaction.txt`;

export const withdrawingTokens = {
  slug: recipe,
  title: "Withdrawing Tokens",
  createdAt: new Date(2022, 3, 1),
  author: "Flow Blockchain",
  playgroundLink:
    "https://play.onflow.org/ef2fe054-148b-4c75-94f1-95bd33b6ce00?type=tx&id=e849d0d1-4196-432c-b9be-eab08c5595a9",
  excerpt:
    "This is included in your smart contract when you would like to implement token withdrawls. Also useful for transferring tokens between accounts.",
  smartContractCode: contractPath,
  smartContractExplanation: smartContractExplanationPath,
  transactionCode: transactionPath,
  transactionExplanation: transactionExplanationPath,
  filters: {
    difficulty: "beginner"
  }
};
