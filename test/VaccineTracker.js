const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("VaccineTracker", function () {
  it("Should return a new VaccineTracker once deployed", async function () {
    const VaccineTracker = await ethers.getContractFactory("VaccineTracker");
    const vaccineTracker = await VaccineTracker.deploy();
    await vaccineTracker.deployed();

  });
  
});
