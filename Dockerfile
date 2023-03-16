FROM node:16.14.2
WORKDIR /var/www/html
COPY ./ ./
RUN npm install -g pnpm
# 由於想要在重啟時，可以重 build 最新的檔案，所以改在 CMD 做
# RUN pnpm install && pnpm cache clean && pnpm build
EXPOSE 3000
CMD ["sh", "-c", "pnpm install && pnpm build && pnpm start"]

# 打包（先進到有 Dockfile 的目錄）
# docker build -t next-docker ./

# 如果想要包含版本描述的打包可以這樣寫
# docker build -t next-docker:next-13 ./

# 創建容器並於創建後開啟終端機，不建議用在 prod，因為服務運行在前台，所以當關閉終端機時，服務也會停止運行，會需要加裝可以讓終端機有分頁的套件如：tmux、screen，或者加裝如 forever、pm2（需預先在 Dockfile 安裝）等進程保護程式
# docker run -it --name <自定義的容器名稱> -p <本地端port>:3000 -v <本地端絕對路徑>:/usr/src/app <imageName> bash

# 創建容器並於創建後直接執行 CMD 內的指令，建議於生產環境使用，由 docker 的 -d 保護程序
# docker run -d --name <自定義的容器名稱> -p <本地端port>:3000 -v <本地端絕對路徑>:/usr/src/app <imageName>

# 重啟容器
# docker stop next-docker
# docker start next-docker

# 如果容器有起來，但 bash 關掉了，重新進入 bash 的方式
# docker exec -it next-docker bash
