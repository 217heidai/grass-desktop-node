# grass-desktop-node
Docker image for [Grass Desktop Node](https://app.getgrass.io/register/?referralCode=mym0QmjqhIN89gy). 
The Grass Desktop Node is a lightweight standalone application that is designed to run on any desktop. Users of the desktop node are awarded priority network traffic and are able to earn additional rewards for occasional access to the user's bandwidth.

## Setup
```bash
docker run -d \
   --restart unless-stopped \
   --name grass \
   --network host \
   -v $HOME/appdata/grass:/config \
   -e USER_ID=$(id -u) \
   -e GROUP_ID=$(id -g) \
   -e WEB_LISTENING_PORT=5800
   217heidai/grass:latest
```
or
```bash
docker run -d \
   --restart unless-stopped \
   --name grass \
   -v $HOME/appdata/grass:/config \
   -e USER_ID=$(id -u) \
   -e GROUP_ID=$(id -g) \
   -p 5800:5800 \
   217heidai/grass:latest
```

## Setting
1. Open the webpage https://yourip:5800
2. Login grass with your grass account
3. Earn more rewards

## ChangeLog
| Date      | Content                                                              |
|-----------|----------------------------------------------------------------------|
| 2025.07.16 | grass 5.5.4  |
| 2025.05.07 | grass 5.3.1  |
| 2025.03.21 | grass 5.2.2  |
| 2025.03.14 | grass 5.2.0  |
| 2025.03.02 | grass 5.1.1  |
| 2025.02.24 | grass 5.1.0  |
| 2025.02.05 | grass 4.32.0 |
| 2025.01.23 | grass 4.31.2 |
| 2024.12.16 | grass 4.30.0 |
| 2024.11.20 | grass 4.29.0 |
| 2024.11.06 | grass 4.28.2 |
| 2024.11.04 | grass 4.28.1 |
| 2024.11.01 | grass 4.28.0 |
| 2024.10.31 | grass 4.27.3 |
