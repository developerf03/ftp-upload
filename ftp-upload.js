#!/usr/bin/env node

const ftp = require("basic-ftp");
const fs = require("fs/promises");
const path = require("path");
const yargs = require("yargs");

const argv = yargs
  .option("host", { alias: "h", demandOption: true, describe: "FTP host", type: "string" })
  .option("user", { alias: "u", demandOption: true, describe: "FTP username", type: "string" })
  .option("pass", { alias: "p", demandOption: true, describe: "FTP password", type: "string" })
  .option("localDir", { alias: "l", demandOption: true, describe: "Local directory to upload", type: "string" })
  .option("remoteDir", { alias: "r", demandOption: true, describe: "Remote target directory", type: "string" })
  .help()
  .argv;

async function uploadDirectory(client, localDir, remoteDir) {
    const entries = await fs.readdir(localDir, { withFileTypes: true });

    await client.ensureDir(remoteDir);
    await client.cd(remoteDir);

    for (const entry of entries) {
        const localPath = path.join(localDir, entry.name);
        const remotePath = path.posix.join(remoteDir, entry.name);

        if (entry.isDirectory()) {
            console.log(`📁 Entering directory: ${localPath}`);
            await uploadDirectory(client, localPath, remotePath);
            await client.cdup();
        } else if (entry.isFile()) {
            console.log(`⬆️ Uploading: ${localPath} -> ${remotePath}`);
            await client.uploadFrom(localPath, entry.name);
        }
    }
}

async function main() {
    const client = new ftp.Client();
    client.ftp.verbose = true;

    try {
        await client.access({
            host: argv.host,
            user: argv.user,
            password: argv.pass,
            secure: false,
        });

        await uploadDirectory(client, argv.localDir, argv.remoteDir);
        console.log("✅ Upload Successfully!");
    } catch (err) {
        console.error("❌ Upload failed:", err.message);
    }

    client.close();
}

main();
