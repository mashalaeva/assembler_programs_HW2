;_ ФИО:      Шалаева Марина Андреевна                         _______
;_ ГРУППА:   БПИ191                                           _______
;_                                                            _______
;_ ВАРИАНТ:  7                                                _______
;_                                                            _______
;_ ЗАДАНИЕ:  разработать программу, которая вводит одномерный _______
;_           массив А[n], формирует из элементов массива А    _______
;_           новый массив В и выводит его.                    _______
;_                                                            _______
;_           Массив В состоит из ИНДЕКСОВ                     _______
;_           ПОЛОЖИТЕЛЬНЫХ ЭЛЕМЕНТОВ А.                       _______

format PE console
include 'win32a.inc'

entry start

;____________________________________________________________________

section '.data' data readable writable

        strVecSize      db 'What is the size of vector?', 10, 0
        strIncorSize    db 'Incorrect size of vector. Try again!', 10, 0
        strVecElemI     db '[%d]? ', 0
        strScanInt      db '%d', 0
        strVecElemOut   db '[%d] = %d', 10, 0
        strVecBracketS  db '[ ', 0
        strVecBracketE  db ']', 10, 0
        strDigit        db '%d ', 0
        strArrA         db 'Array A: ', 0
        strArrB         db 'Array B: ', 0

        arrA_size       dd 0
        arrB_size       dd 0
        arrA            rd 100
        arrB            rd 100
        i               dd ?
        tmp             dd ?
        tmpB            dd ?
        stackPointer    dd ?
        a               dd ?

        NULL = 0

;____________________________________________________________________

section '.code' code readable executable

;________________________________MAIN________________________________

        start:
                _tryAgain:
                push strVecSize
                call [printf]

                push arrA_size
                push strScanInt
                call [scanf]

;__Если размер массива А неверный, просим ввести заново._____________
;__Иначе считываем массив:___________________________________________

                mov  eax, [arrA_size]
                cmp  eax, 0
                jle incorrectInput
                jg  successInput
                jmp finish

;__Если размер массива неверный: ____________________________________

        incorrectInput:

                push strIncorSize
                call [printf]
                jmp _tryAgain

;__Если размер массива верный:_______________________________________

        successInput:

;__Считывание массива А:_____________________________________________
                push [arrA_size]
                push arrA
                call readArr

;__Создание массива В:_______________________________________________
                push [arrA_size]
                push arrA
                push arrB
                call createArrB

;__Вывод массивов А и В:_____________________________________________
                push strArrA
                call [printf]

                push [arrA_size]
                push arrA
                call printArr

                push strArrB
                call [printf]

                push [arrB_size]
                push arrB
                call printArr

        finish:
                call [getch]
                push NULL
                call ExitProcess

;____________________________________________________________________

;__Считывание введенного пользователем массива:______________________
        readArr:

;__Сохранение значений регистров в стеке:____________________________
                push eax
;__Запись значения указателя стека в регистр eax:____________________
                mov  eax, esp
                push ecx
                push edx

                xor  ecx, ecx ;_ecx = 0______________________________

                mov  edx, [ss:eax+8+0] ;_[ss:eax+8+0] == arrA________

        inputArrLoop:

;__Сохранение значений регистров в переменные:_______________________
                mov  [stackPointer], eax
                mov  [tmp], edx
                cmp  ecx, [ss:eax+8+4]
                jge  endInputArrLoop

;__Считывание элемента:______________________________________________
                mov  [i], ecx
                push ecx
                push strVecElemI
                call [printf]

                push [tmp]
                push strScanInt
                call [scanf]

;__Восстанавление нужных значенй регистров из переменных, в__________
;__которых были записаны значения до этого:__________________________
                mov  ecx, [i]
                inc  ecx
                mov  edx, [tmp]
                add  edx, 4
                mov  eax, [stackPointer]
                jmp  inputArrLoop

        endInputArrLoop:

                sub  eax, 8
                mov  esp, eax
;__Возвращаем регистрам их прежние значения:_________________________
                pop  edx
                pop  ecx
                pop  eax

        ret

;____________________________________________________________________

;__Создание массива В из индексов положительных элементов массива А:_
        createArrB:

;__Сохранение значения регистров в стеке:____________________________
                push eax
;__Запись значения указателя в регист eax:___________________________
                mov  eax, esp
                push ecx
                push edx
                push ebx

;__Запись ссылки на массив А в edx:__________________________________
                mov  edx, [ss:eax+8+4]
;__Запись ссылки на массив B в edx:__________________________________
                mov  ebx, [ss:eax+8+0]
;__Запись количества элементов массива А:____________________________
                mov  ecx, [ss:eax+8+8]

                xor  ecx, ecx ;__ecx = 0_____________________________

        newArrBLoop:
                mov  [tmp], edx
                mov  [tmpB], ebx
                mov  [i], ecx

;__Проверка на превышение размера массива счетчиком:_________________
                cmp  ecx, [ss:eax+8+8]
                jge  endArrBLoop

;__Проверка на положительность:______________________________________
                mov  ecx, 0
                cmp  [edx], ecx
                jle   getIndex

;__Внесение элемента arrA[i] в arrB:_________________________________
                mov  ecx, [i]
                mov  [ebx], ecx
                mov  ebx, [tmpB]
                add  ebx, 4
                inc  [arrB_size]

        getIndex:
;__Внесение индекса i в arrB:________________________________________
                mov  ecx, [i]
                mov edx, [tmp]
                add edx, 4
                inc ecx
                jmp  newArrBLoop

        endArrBLoop:
                sub  eax, 12
                mov  esp, eax

                pop  ebx
                pop  edx
                pop  ecx
                pop  eax

        ret

;____________________________________________________________________

;__Вывод массивса на экран:__________________________________________

        printArr:
;__Сохранение значения регистров в стеке:____________________________
                push eax
                mov  eax, esp
                push ecx
                push edx

                mov  [stackPointer], eax

                push strVecBracketS
                call [printf]

                mov  eax, [stackPointer]

                xor  ecx, ecx
                mov  edx, [ss:eax+8+0]

        printArrLoop:
;__Сохранение значения регистров в переменные:_______________________
                mov  [tmp], edx
                mov  [i], ecx

;__Сравнение длины массива с есх:____________________________________
                cmp  ecx, [ss:eax+8+4]
                jge  endPrintArrLoop

                mov  ecx, [edx]
                push ecx
                push strDigit
                call [printf]

;__Восстанавление значения регистров:________________________________
                mov  edx, [tmp]
                add  edx, 4
                mov  ecx, [i]
                inc  ecx
                mov  eax, [stackPointer]
                jmp  printArrLoop

        endPrintArrLoop:
                push strVecBracketE ;__Вывод правой скобки___________
                call [printf]

;__Восстанавление значения регистра eax после printf:________________
                mov  eax, [stackPointer]

                sub  eax, 8
                mov  esp, eax
                pop  edx
                pop  ecx
                pop  eax

        ret

;____________________________________________________________________

section '.idata' data readable import

        library kernel, 'kernel32.dll', msvcrt, 'msvcrt.dll'
        import kernel, ExitProcess, 'ExitProcess'
        import msvcrt, printf, 'printf', scanf, 'scanf', getch, '_getch'
