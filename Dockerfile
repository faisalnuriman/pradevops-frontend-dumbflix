# Menggunakan image Node.js sebagai base image
FROM node:10.24.1

# Menetapkan direktori kerja di dalam container
WORKDIR /usr/src/app

# Menyalin file package.json dan package-lock.json ke dalam direktori kerja
COPY package*.json ./

# Menginstal dependensi aplikasi
RUN npm install

# Menyalin semua file aplikasi ke dalam direktori kerja
COPY . .

# Mengekspos port 3000
EXPOSE 3000

# Menjalankan aplikasi
CMD ["npm", "start"]
