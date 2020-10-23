const election = artifacts.require("election");

module.exports = function (deployer) {
  deployer.deploy(election);
};
