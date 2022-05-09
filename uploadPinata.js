require('dotenv').config();
const key = process.env.PINATA_API_KEY;
const secret = process.env.PINATA_API_SECRET;
const pinataSDK = require('@pinata/sdk');
const pinata = pinataSDK(key, secret);
const fs = require('fs');
const readableStreamForFile = fs.createReadStream('./images/shiba-inu.png');

const options = {
    pinataMetadata: {
        name: "AlyraNFT",
    },
    pinataOptions: {
        cidVersion: 0
    }
};


pinata.pinFileToIPFS(readableStreamForFile, options).then((result) => {
    const body = {
        description: "Un Shiba Inu NFT",
        image: result.IpfsHash,
        name: "NFT TWC",
    };

    pinata.pinJSONToIPFS(body, options).then((json) => {
        console.log(json);
    }).catch((err) => {
        console.log(err);
    });

}).catch((err) => {
    console.log(err);
});
