const TokenLocker = artifacts.require('TokenLocker');

module.exports = function(deployer) {
  deployer.deploy(
    TokenLocker, 
    '0xb6505dEfE58759C09e0dF0739f8F5A6f32bffd44',
    '1800',
    '900000000'
  );
}