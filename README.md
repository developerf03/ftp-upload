# xdeploy CLI

> Cli for upload local all file to remote server

## Installation Guide 

### 1. Install xdeploy via curl

```
sh -c "$(curl -fsSL https://github.com/developerf03/ftp-upload/install.sh)"

```

### 2. Enter your password

```
[sudo] password for your_user: ********
```

### 3. Verify the CLI is installed

```
xdeploy

Options:
      --version    Show version number                                 [boolean]
  -h, --host       FTP host                                  [string] [required]
  -u, --user       FTP username                              [string] [required]
  -p, --pass       FTP password                              [string] [required]
  -l, --localDir   Local directory to upload                 [string] [required]
  -r, --remoteDir  Remote target directory                   [string] [required]
      --help       Show help                                           [boolean]

Missing required arguments: host, user, pass, localDir, remoteDir
```