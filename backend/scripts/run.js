const hre = require('hardhat') 

const main = async () => {
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal")
    const waveContract = await waveContractFactory.deploy({value: hre.ethers.utils.parseEther('0.001')})
    await waveContract.deployed()

    console.log('Contract Address', waveContract.address)
}

main()
    .then(() => process.exit(0))
    .then((error) => {
        console.log(error)
        process.exit(1)
    })