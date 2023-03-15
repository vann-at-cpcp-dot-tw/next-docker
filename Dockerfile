FROM node:16.14.2
WORKDIR /usr/src/app
COPY package.json yarn.lock ./
# 由於想要在重啟時，可以重 build 最新的檔案，所以改在 CMD 做
# RUN yarn install && yarn cache clean
COPY . .
# 由於想要在重啟時，可以重 build 最新的檔案，所以改在 CMD 做
# RUN yarn build
EXPOSE 3000
CMD ["sh", "-c", "yarn install && yarn build && yarn start"]

# 打包（先進到有 Dockfile 的目錄）
# docker build -t next-docker ./
# docker build -t next-docker:next-13 ./

# 創建容器並於創建後開啟終端機，不建議用在 prod，因為服務運行在前台，所以當關閉終端機時，服務也會停止運行，會需要加裝可以讓終端機有分頁的套件如：tmux、screen，或者加裝如 forever、pm2（需預先在 Dockfile 安裝）等進程保護程式
# docker run -it --name <自定義的容器名稱> -p <本地端port>:3000 -v <本地端絕對路徑>:/usr/src/app <imageName> bash
#=> docker run -it --name next-docker -p 3000:3000 -v /Users/vann/Sites/next-docker:/usr/src/app next-docker bash

# 創建容器並於創建後直接執行 CMD 內的指令，建議於生產環境使用，由 docker 的 -d 保護程序
# docker run -d --name <自定義的容器名稱> -p <本地端port>:3000 -v <本地端絕對路徑>:/usr/src/app <imageName>
#=> docker run -d --name next-docker -p 3000:3000 -v /Users/vann/Sites/next-docker:/usr/src/app next-docker

# 重啟容器
# docker stop next-docker
# docker start next-docker

# 如果容器有起來，但 bash 關掉了，重新進入 bash 的方式
# docker exec -it next-docker bash


##### compose 版（建議）#####
# 創建 + 啟動容器
# docker compose up -d

# 關閉容器
# docker compose down

#  yarn 重 build & 重啟
# docker compose restart
