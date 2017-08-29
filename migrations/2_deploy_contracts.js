var ConvertLib = artifacts.require("./ConvertLib.sol");
var MetaCoin = artifacts.require("./MetaCoin.sol");
var animesh = artifacts.require("./Animesh.sol");
var practice = artifacts.require("./practice.sol");
module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, animesh);
  //deployer.deploy(MetaCoin);
  //deployer.deploy(practice);
};
