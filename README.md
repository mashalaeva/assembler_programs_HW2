# assembler_programs_HW2

Все исходники можно найти в папке Homework2.

В папке "Homework2\Code" хранятся скриншоты кода.

В папке "Homework2\Result" хранятся скриншоты тестов.

Программа
=====================

Ниже представлен код программы, которая вводит одномерный массив A[N], формирует из элементов массива A новый массив B и выводит его.
Массив В формируется из индексов положительных элементов массива A:

![Код программы 1:](https://sun9-53.userapi.com/HmQH_h3CVnmYEDIUtH8-ehokqGf4CX7WXHKzwQ/B1qWnVkawCQ.jpg)
![Код программы 2:](https://sun9-32.userapi.com/bgIiIzEQJKPw9op5iZvPvTLVsttzg9qolv696A/SCp1xbARt8U.jpg)
![Код программы 3:](https://sun9-34.userapi.com/JlhDvdyfjE3C0j3UVH6RVW7K9yf3lBeqp_NYlQ/UNckjwg22E4.jpg)
![Код программы 4:](https://sun9-5.userapi.com/eznqZIQKPHMd8AVXgAPOljgBM1O9Mhy9KpthCw/9R7I5RWx-rk.jpg)
![Код программы 5:](https://sun9-42.userapi.com/WtxVacrCnLz70lJlRb9YYsBtpMqq_hRSMP9OZA/otqLCYpcXAo.jpg)
![Код программы 6:](https://sun9-54.userapi.com/RNAcvV6IOFyz518lrVQ5QU-KUMgJfep2P3dwvw/DlGuPZPcfUQ.jpg)
![Код программы 7:](https://sun4-10.userapi.com/cUKiWCVwDOpMKLT0HzWJq1JsbxE0OnnCxi4afA/xAabCyw8BSI.jpg)
![Код программы 8:](https://sun4-16.userapi.com/Pe59jthRomzN4k9ScwV_Z62GeLFxoKleIhHNGg/sDylmZ7LHQ8.jpg)
![Код программы 9:](https://sun4-12.userapi.com/n6C9GtAr2HKGZJPPtv--e6By3qjhmctmaMc8yg/EpmxGdgP3lk.jpg)

### Результат выполнения:

Для того чтобы продемонстрировать работу данной программы, вводим рандомный допустимый размер массива (например, 10), после чего по очереди вводим элементы массива (каждый с новой строчки).

Введем рандомные значения, например, 1, -2, 3, -4, 5, -6, 7, -8, 9, 10.

Массив В должен включать в себя индексы элементов 1, 3, 5, 7, 9 и 10. Поскольку индексы массива считаются с нуля, массив В должен состоять из значений 0, 2, 4, 6, 8 и 9. 

Протестируем программу с вышеупомянутыми входными данными и посмотрим, совпадает ли ответ с предполагаемым:

![Результат выполнения 1:](https://sun4-15.userapi.com/kYbS7ow6eiffQSw4h7JHj9G67yYldqntKpU6tQ/PyOrPMyGSJY.jpg)

С корректными входными данными программа работает верно!
****
Теперь попробуем ввести некорректные входные данные и записать в массив исключительно отрицательные элементы:

![Результат выполнения 2:](https://sun9-20.userapi.com/JIebg8NYHiCNbTMFWm0L3djBhQs5fluOkWParw/hJyIEmZyPP8.jpg)

Программа также не прерывает свою работу. 
При вводе некорректного размера массива в консоль выводится просьба ввести размер еще раз; при записи исключительно отрицательных элементов в массив А программа выводит в консоль пустой массив в качестве выходного.
