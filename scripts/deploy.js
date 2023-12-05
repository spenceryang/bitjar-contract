async function main() {
  const WBTCVault = await hre.ethers.getContractFactory("WBTCVault");
  const wbtcTokenAddress = "0x29f2D40B0605204364af54EC677bD022dA425d03"; // Replace with WBTC token address
  const aavePoolAddress = "0x6Ae43d3271ff6888e7Fc43Fd7321a503ff738951"; // Replace with Aave V3 lending pool address

  try {
    const wbtcVault = await WBTCVault.deploy(wbtcTokenAddress, aavePoolAddress);

    console.log(`WBTCVault deployed to:, ${wbtcVault.address}`);
  } catch (error) {
    console.error("Deployment failed:", error);
  }
}

main().catch((error) => {
  console.error("Script execution failed:", error);
  process.exitCode = 1;
});
