const Adjustment = artifacts.require('./Adjustment.sol');

module.exports = async (deployer) => {
  let adjustment = await deployer.deploy(Adjustment);
};
