const TokenLocker = artifacts.require('TokenLocker');

module.exports = function(deployer) {
  deployer.deploy(
    TokenLocker,
    '0xC59615DA2DA226613B1C78F0c6676CAC497910bC',
    '1800',
    '900000000'
  );
}