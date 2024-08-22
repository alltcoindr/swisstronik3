sudo apt update
sudo apt upgrade
wget -O loader.sh https://raw.githubusercontent.com/DiscoverMyself/Ramanode-Guides/main/loader.sh && chmod +x loader.sh && ./loader.sh
curl -s https://raw.githubusercontent.com/DiscoverMyself/Ramanode-Guides/main/logo.sh | bash
sleep 4
sudo apt-get update && sudo apt-get upgrade -y
clear
echo "Installing dependencies..."
npm install --save-dev hardhat
npm install dotenv
npm install @swisstronik/utils
npm install @openzeppelin/contracts
echo "Installation completed."
echo "Creating a Hardhat project..."
npx hardhat
rm -f contracts/Lock.sol
echo "Lock.sol removed."
echo "Hardhat project created."
echo "Installing Hardhat toolbox..."
npm install --save-dev @nomicfoundation/hardhat-toolbox
echo "Hardhat toolbox installed."
echo "Creating .env file..."
read -p "Enter your private key: " 7de8e748a365cb5bce5e59451d9f457946dbee0ebd335fae25b3eaf4eb0ccd6f
echo "PRIVATE_KEY=$PRIVATE_KEY" > .env
echo ".env file created."
echo "Creating .env file..."
read -p " echo "Creating .env file..."
read -p "Enter your private key: "7de8e748a365cb5bce5e59451d9f457946dbee0ebd335fae25b3eaf4eb0ccd6f
echo "PRIVATE_KEY=$PRIVATE_KEY" > .env
echo ".env file created."
: " PRIVATE_KEY
echo "PRIVATE_KEY=$PRIVATE_KEY" > .env
echo ".env file created."
echo "Creating .env file..."
read -p "7de8e748a365cb5bce5e59451d9f457946dbee0ebd335fae25b3eaf4eb0ccd6f: " PRIVATE_KEY
echo "PRIVATE_KEY=$PRIVATE_KEY" > .env
echo ".env file created."
echo "Configuring Hardhat..."
cat <<EOL > hardhat.config.js
require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: "0.8.20",
  networks: {
    swisstronik: {
      url: "https://json-rpc.testnet.swisstronik.com/",
      accounts: [\`0x\${process.env.PRIVATE_KEY}\`],
    },
  },
};
EOL

echo "Hardhat configuration completed."
read -p "Enter the NFT name: " NFT_NAME
read -p "Enter the NFT symbol: " NFT_SYMBOL
echo "Creating NFT.sol contract..."
mkdir -p contracts
cat <<EOL > contracts/NFT.sol
// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";

contract TestNFT is ERC721, ERC721Burnable {
    constructor()
        ERC721("$NFT_NAME","$NFT_SYMBOL")
    {}

    function safeMint(address to, uint256 tokenId) public {
        _safeMint(to, tokenId);
    }
}
EOL

echo "NFT.sol contract created."
echo "Compiling the contract..."
npx hardhat compile
echo "Contract compiled."
echo "Creating deploy.js script..."
mkdir -p scripts
cat <<EOL > scripts/deploy.js
const hre = require("hardhat");
const fs = require("fs");

async function main() {
  const contract = await hre.ethers.deployContract("TestNFT");
  await contract.waitForDeployment();
  const deployedContract = await contract.getAddress();
  fs.writeFileSync("contract.txt", deployedContract);
  console.log(\`Contract deployed to \${deployedContract}\`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
EOL

echo "deploy.js script created."
echo "Deploying the contract..."
npx hardhat run scripts/deploy.js --network swisstronik
echo "Contract deployed."
echo "Creating mint.js script..."
cat <<EOL > scripts/mint.js
const hre = require("hardhat");
const fs = require("fs");
const { encryptDataField, decryptNodeResponse } = require("@swisstronik/utils");

const sendShieldedTransaction = async (signer, destination, data, value) => {
  const rpcLink = hre.network.config.url;
  const [encryptedData] = await encryptDataField(rpcLink, data);
  return await signer.sendTransaction({
    from: signer.address,
    to: destination,
    data: encryptedData,
    value,
  });
};

async function main() {
  const contractAddress = fs.readFileSync("contract.txt", "utf8").trim();
  const [signer] = await hre.ethers.getSigners();
  const contractFactory = await hre.ethers.getContractFactory("TestNFT");
  const contract = contractFactory.attach(contractAddress);
  const functionName = "safeMint";
  const safeMintTx = await sendShieldedTransaction(
    signer,
    contractAddress,
    contract.interface.encodeFunctionData(functionName, [signer.address, 1]),
    0
  );
  await safeMintTx.wait();
  console.log("Transaction Receipt: ", \`Minting NFT has been success! Transaction hash: https://explorer-evm.testnet.swisstronik.com/tx/\${safeMintTx.hash}\`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
EOL

echo "mint.js script created."
echo "Minting NFT..."
npx hardhat run scripts/mint.js --network swisstronik
echo "NFT minted."
apt install npm
echo "Creating NFT.sol contract..."
mkdir -p contracts
cat <<EOL > contracts/NFT.sol
// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";

contract TestNFT is ERC721, ERC721Burnable {
    constructor()
        ERC721("$NFT_NAME","$NFT_SYMBOL")
    {}

    function safeMint(address to, uint256 tokenId) public {
        _safeMint(to, tokenId);
    }
}
EOL

echo "NFT.sol contract created."
echo "Compiling the contract..."
npx hardhat compile
echo "Contract compiled."
echo "Creating deploy.js script..."
mkdir -p scripts
cat <<EOL > scripts/deploy.js
const hre = require("hardhat");
const fs = require("fs");

async function main() {
  const contract = await hre.ethers.deployContract("TestNFT");
  await contract.waitForDeployment();
  const deployedContract = await contract.getAddress();
  fs.writeFileSync("contract.txt", deployedContract);
  console.log(\`Contract deployed to \${deployedContract}\`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
EOL

echo "deploy.js script created."
echo "Deploying the contract..."
npx hardhat run scripts/deploy.js --network swisstronik
echo "Contract deployed."
echo "Creating mint.js script..."
cat <<EOL > scripts/mint.js
const hre = require("hardhat");
const fs = require("fs");
const { encryptDataField, decryptNodeResponse } = require("@swisstronik/utils");

const sendShieldedTransaction = async (signer, destination, data, value) => {
  const rpcLink = hre.network.config.url;
  const [encryptedData] = await encryptDataField(rpcLink, data);
  return await signer.sendTransaction({
    from: signer.address,
    to: destination,
    data: encryptedData,
    value,
  });
};

async function main() {
  const contractAddress = fs.readFileSync("contract.txt", "utf8").trim();
  const [signer] = await hre.ethers.getSigners();
  const contractFactory = await hre.ethers.getContractFactory("TestNFT");
  const contract = contractFactory.attach(contractAddress);
  const functionName = "safeMint";
  const safeMintTx = await sendShieldedTransaction(
    signer,
    contractAddress,
    contract.interface.encodeFunctionData(functionName, [signer.address, 1]),
    0
  );
  await safeMintTx.wait();
  console.log("Transaction Receipt: ", \`Minting NFT has been success! Transaction hash: https://explorer-evm.testnet.swisstronik.com/tx/\${safeMintTx.hash}\`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
EOL

echo "mint.js script created."
echo "Minting NFT..."
npx hardhat run scripts/mint.js --network swisstronik
echo "NFT minted."
npm install -g npm
npm fund
node -v
npm -v
echo "Creating NFT.sol contract..."
mkdir -p contracts
cat <<EOL > contracts/NFT.sol
// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";

contract TestNFT is ERC721, ERC721Burnable {
    constructor()
        ERC721("$NFT_NAME","$NFT_SYMBOL")
    {}

    function safeMint(address to, uint256 tokenId) public {
        _safeMint(to, tokenId);
    }
}
EOL

echo "NFT.sol contract created."
echo "Compiling the contract..."
npx hardhat compile
echo "Contract compiled."
echo "Creating deploy.js script..."
mkdir -p scripts
cat <<EOL > scripts/deploy.js
const hre = require("hardhat");
const fs = require("fs");

async function main() {
  const contract = await hre.ethers.deployContract("TestNFT");
  await contract.waitForDeployment();
  const deployedContract = await contract.getAddress();
  fs.writeFileSync("contract.txt", deployedContract);
  console.log(\`Contract deployed to \${deployedContract}\`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
EOL

echo "deploy.js script created."
echo "Deploying the contract..."
npx hardhat run scripts/deploy.js --network swisstronik
echo "Contract deployed."
echo "Creating mint.js script..."
cat <<EOL > scripts/mint.js
const hre = require("hardhat");
const fs = require("fs");
const { encryptDataField, decryptNodeResponse } = require("@swisstronik/utils");

const sendShieldedTransaction = async (signer, destination, data, value) => {
  const rpcLink = hre.network.config.url;
  const [encryptedData] = await encryptDataField(rpcLink, data);
  return await signer.sendTransaction({
    from: signer.address,
    to: destination,
    data: encryptedData,
    value,
  });
};

async function main() {
  const contractAddress = fs.readFileSync("contract.txt", "utf8").trim();
  const [signer] = await hre.ethers.getSigners();
  const contractFactory = await hre.ethers.getContractFactory("TestNFT");
  const contract = contractFactory.attach(contractAddress);
  const functionName = "safeMint";
  const safeMintTx = await sendShieldedTransaction(
    signer,
    contractAddress,
    contract.interface.encodeFunctionData(functionName, [signer.address, 1]),
    0
  );
  await safeMintTx.wait();
  console.log("Transaction Receipt: ", \`Minting NFT has been success! Transaction hash: https://explorer-evm.testnet.swisstronik.com/tx/\${safeMintTx.hash}\`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
EOL

echo "mint.js script created."
echo "Minting NFT..."
npx hardhat run scripts/mint.js --network swisstronik
echo "NFT minted."
npm install --save-dev hardhat.
yarn add --dev hardhat.
apt install cmdtest
npm install --save-dev hardhat.
yarn add --dev hardhat.
yarn add --dev hardhat
yarn add dev hardhat.
npx hardhat console
npm install --save-dev hardhat
yarn add --dev hardhat
yarn add -dev hardhat
yarn add --save-dev hardhat
npx hardhat compile
npx hardhat console
npx hardhat init
echo "Creating NFT.sol contract..."
mkdir -p contracts
cat <<EOL > contracts/NFT.sol
// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";

contract TestNFT is ERC721, ERC721Burnable {
    constructor()
        ERC721("$NFT_NAME","$NFT_SYMBOL")
    {}

    function safeMint(address to, uint256 tokenId) public {
        _safeMint(to, tokenId);
    }
}
EOL

echo "NFT.sol contract created."
echo "Compiling the contract..."
npx hardhat compile
echo "Contract compiled."
echo "Creating deploy.js script..."
mkdir -p scripts
cat <<EOL > scripts/deploy.js
const hre = require("hardhat");
const fs = require("fs");

async function main() {
  const contract = await hre.ethers.deployContract("TestNFT");
  await contract.waitForDeployment();
  const deployedContract = await contract.getAddress();
  fs.writeFileSync("contract.txt", deployedContract);
  console.log(\`Contract deployed to \${deployedContract}\`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
EOL

echo "deploy.js script created."
echo "Deploying the contract..."
npx hardhat run scripts/deploy.js --network swisstronik
echo "Contract deployed."
echo "Creating mint.js script..."
cat <<EOL > scripts/mint.js
const hre = require("hardhat");
const fs = require("fs");
const { encryptDataField, decryptNodeResponse } = require("@swisstronik/utils");

const sendShieldedTransaction = async (signer, destination, data, value) => {
  const rpcLink = hre.network.config.url;
  const [encryptedData] = await encryptDataField(rpcLink, data);
  return await signer.sendTransaction({
    from: signer.address,
    to: destination,
    data: encryptedData,
    value,
  });
};

async function main() {
  const contractAddress = fs.readFileSync("contract.txt", "utf8").trim();
  const [signer] = await hre.ethers.getSigners();
  const contractFactory = await hre.ethers.getContractFactory("TestNFT");
  const contract = contractFactory.attach(contractAddress);
  const functionName = "safeMint";
  const safeMintTx = await sendShieldedTransaction(
    signer,
    contractAddress,
    contract.interface.encodeFunctionData(functionName, [signer.address, 1]),
    0
  );
  await safeMintTx.wait();
  console.log("Transaction Receipt: ", \`Minting NFT has been success! Transaction hash: https://explorer-evm.testnet.swisstronik.com/tx/\${safeMintTx.hash}\`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
EOL

echo "mint.js script created."
echo "Minting NFT..."
npx hardhat run scripts/mint.js --network swisstronik
echo "NFT minted."
- /root/hardhat.config.js
- /root/node_modules/hardhat/internal/core/config/config-loading.js
- /root/node_modules/hardhat/internal/cli/cli.js
- /root/node_modules/hardhat/internal/cli/bootstrap.js
hardhat.config.js
apt hardhat.config.js
$ npx hardhat
npx hardhat
npm install --save-dev hardhat
npm audit fix
npm fund
npx hardhat
echo "Creating NFT.sol contract..."
mkdir -p contracts
cat <<EOL > contracts/NFT.sol
// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";

contract TestNFT is ERC721, ERC721Burnable {
    constructor()
        ERC721("$NFT_NAME","$NFT_SYMBOL")
    {}

    function safeMint(address to, uint256 tokenId) public {
        _safeMint(to, tokenId);
    }
}
EOL

echo "NFT.sol contract created."
echo "Compiling the contract..."
npx hardhat compile
echo "Contract compiled."
echo "Creating deploy.js script..."
mkdir -p scripts
cat <<EOL > scripts/deploy.js
const hre = require("hardhat");
const fs = require("fs");

async function main() {
  const contract = await hre.ethers.deployContract("TestNFT");
  await contract.waitForDeployment();
  const deployedContract = await contract.getAddress();
  fs.writeFileSync("contract.txt", deployedContract);
  console.log(\`Contract deployed to \${deployedContract}\`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
EOL

echo "deploy.js script created."
echo "Deploying the contract..."
npx hardhat run scripts/deploy.js --network swisstronik
echo "Contract deployed."
echo "Creating mint.js script..."
cat <<EOL > scripts/mint.js
const hre = require("hardhat");
const fs = require("fs");
const { encryptDataField, decryptNodeResponse } = require("@swisstronik/utils");

const sendShieldedTransaction = async (signer, destination, data, value) => {
  const rpcLink = hre.network.config.url;
  const [encryptedData] = await encryptDataField(rpcLink, data);
  return await signer.sendTransaction({
    from: signer.address,
    to: destination,
    data: encryptedData,
    value,
  });
};

async function main() {
  const contractAddress = fs.readFileSync("contract.txt", "utf8").trim();
  const [signer] = await hre.ethers.getSigners();
  const contractFactory = await hre.ethers.getContractFactory("TestNFT");
  const contract = contractFactory.attach(contractAddress);
  const functionName = "safeMint";
  const safeMintTx = await sendShieldedTransaction(
    signer,
    contractAddress,
    contract.interface.encodeFunctionData(functionName, [signer.address, 1]),
    0
  );
  await safeMintTx.wait();
  console.log("Transaction Receipt: ", \`Minting NFT has been success! Transaction hash: https://explorer-evm.testnet.swisstronik.com/tx/\${safeMintTx.hash}\`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
EOL

echo "mint.js script created."
echo "Minting NFT..."
npx hardhat run scripts/mint.js --network swisstronik
echo "NFT minted."
yarn add --dev hardhat
yarn
yarn add hardhat
yarn hardhat
npm install --save-dev hardhat
npx hardhat init
apt install Node.js
// server.mjs
import { createServer } from 'node:http';
const server = createServer((req, res) => {
});
// starts a simple http server locally on port 3000
server.listen(3000, '127.0.0.1', () => {
});
// run with `node server.mjs`
apt install imagemagick-6.q16hdri    
node -v
mkdir hardhat-tut && cd hardhat-tut
yarn init --yes
yarn add hardhat
yarn init
yarn add hardhat
yarn init
sudo yarn init
sudo apt yarn init
yarn -init
