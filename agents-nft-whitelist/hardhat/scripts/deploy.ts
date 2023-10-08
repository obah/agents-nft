import hre from "hardhat";
// import hre from 'hardhat';

type Time = number;

async function sleep(ms: Time) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function main() {
  console.log("-----------------------------");
  console.log("Deploying whitelist contract");

  const whitelistContract = await hre.ethers.deployContract("Whitelist", [50]);
  await whitelistContract.waitForDeployment();

  console.log(`Whitelist contract deployed at: ${whitelistContract.target}`);

  await sleep(30 * 1000);

  await hre.run("verify:verify", {
    address: whitelistContract.target,
    constructorArguments: [50],
  });
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
