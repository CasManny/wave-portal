const hre = require('hardhat')

const main = async () => {
  const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
  const waveContract =  await waveContractFactory.deploy({value: hre.ethers.utils.parseEther('0.01')});
  await waveContract.deployed()
  console.log("Contract deploying, please wait...")

  const wave = await waveContract.wave("This is casmany calling the wave function");
  await wave.wait();

  const wavers = await waveContract.getAllWavers()
  const wavings = wavers.map((wave) => {
    return {
      address: wave.waver,
      message: wave.message,
      timestamp: new Date(wave.timestamp * 1000)
    }
  })

  console.log(wavings)



}

main()
  .then(() => process.exit(0))
  .then((error) => {
    console.log(error)
    process.exit(1)
  })