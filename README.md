# Autotune PID

Repository ini terdiri dari file *source code* yang merupakan implementasi dari *Genetic Algorithm* untuk melakukan penalaan kendali PID.

Kendali PID (*Proportional*, *Integral*, *Derivative*) merupakan sistem kendali yang dapat mengatur atau meregulasi sinyal untuk sebuah sistem. Blok diagram PID ditunjukkan pada gambar di bawah:

<p align="center">
<img src="https://www.researchgate.net/profile/Hari-Bansal/publication/268802558/figure/fig1/AS:669373450682369@1536602475197/Block-diagram-of-a-system-with-PID-controller.png" width="300">
</p>

Blok diagram di atas mengilustrasikan persamaan berikut:

<p align="center"><img src="./asset/pid-equ.png" height=40px></p>

Dimana `u(t)` adalah `Control signal`. Fungsi PID dapat direpresentasikan menjadi *transfer function*, yaitu:

<p align="center"><img src="./asset/transfer-function.png" height=40px></p>

Sehingga, kendali PID membutuhkan tiga parameter yaitu `Kp`, `Ki`, dan `Kd`.

*Genetic Algorithm* (GA) adalah sebuah metode optimasi fungsi yang mencari individu 'terbaik' pada suatu generasi. Pada implementasi ini, individu 'terbaik' didefinisikan berdasarkan nilai error terkecil antara respon *step* sistem yang diberikan dan yang diinginkan.

Pada pendekatan ini, digunakan metode optimasi *Genetic Algorithm* yang diimplementasi *from scratch* dari <a href="https://github.com/Samuel-Ayankoso/Real-Coded-Genetic-Algorithm-GA-">Samuel-Ayankoso/Real-Coded-Genetic-Algorithm-GA</a> dengan beberapa penyesuaian. Beberapa penyesuaian tersebut antara lain:

- *Fitness function* yang disusun didasarkan dari hasil selisih `stepinfo()` dengan nilai yang diinginkan (*desired value*).
-  Sistem yang diuji adalah sistem diskrit yang diubah menggunakan `c2d()` dengan metode *ZOH*.

## Cara Penggunaan

Untuk menggunakan, ikuti langkah berikut:

1. Definisikan sistem dan nilai respon yang diinginkan pada file `defineSys.m`
2. Definisikan parameter GA pada file `main.m`
3. Jalankan `main.m` di aplikasi MATLAB