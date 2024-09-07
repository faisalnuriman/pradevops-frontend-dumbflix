# Menggunakan image Node.js sebagai base image
FROM node:14

# Menetapkan direktori kerja di dalam container
WORKDIR /usr/src/app

# Menyalin package.json dan package-lock.json
COPY package*.json ./

# Menginstal dependensi aplikasi
RUN npm install

# Menginstal PM2 secara global
RUN npm install -g pm2

# Menyalin sisa kode aplikasi ke dalam container
COPY . .

# Membangun aplikasi untuk produksi
RUN npm run build

# Menyediakan port untuk aplikasi
EXPOSE 3000

# Menjalankan aplikasi menggunakan PM2
CMD ["pm2-runtime", "start", "npm", "--", "start"]
