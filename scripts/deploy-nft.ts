import hre from "hardhat";

type Time = number;

const whitelistDeployment = "0x6b4f1d179a6151199a737460c3f09f5855e8f776";

async function sleep(ms: Time) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function main() {
  console.log("-----------------------------");
  console.log("Deploying AgentsNft contract");

  const agentsNftContract = await hre.ethers.deployContract("AgentsNFT", [
    whitelistDeployment,
  ]);
  await agentsNftContract.waitForDeployment();

  console.log(`AgentsNFTContract deployed at: ${agentsNftContract.target}`);

  await sleep(30 * 1000);

  await hre.run("verify:verify", {
    address: agentsNftContract.target,
    constructorArguments: [whitelistDeployment],
  });
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
