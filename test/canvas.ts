import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { expect } from "chai";
import { ethers } from "hardhat";
import type { Canvas } from "../typechain-types/Canvas";

const isSorted = (arr: number[]) => arr.every((v, i, a) => !i || a[i - 1] <= v);
const { parseEther } = ethers.utils;
const { BigNumber: BN } = ethers;

describe("Canvas contract", function () {
  let factory;
  let contract: Canvas;
  let owner: SignerWithAddress;
  let addr1: SignerWithAddress;
  let addr2: SignerWithAddress;
  let addr3: SignerWithAddress;
  let addr4: SignerWithAddress;
  let addrs: SignerWithAddress[];

  beforeEach(async function () {
    factory = await ethers.getContractFactory("Canvas");
    [owner, addr1, addr2, addr3, addr4, ...addrs] = await ethers.getSigners();

    contract = (await factory.deploy()) as Canvas;
  });

  describe("Deployment", function () {
    it("Should set the right owner", async function () {
      expect(await contract.getOwner()).to.equal(owner.address);
    });
  });
});
