'*************************************CONFIGURO EL MICRO********************************************************
$regfile = "m328pdef.dat"
$crystal = 16000000
$hwstack = 40
$swstack = 16
$framesize = 32
'**************************************************************************************************************

'*****************************CONFIGURACION DE PINES Y VARIABLES*****************************************************
Config Lcdpin = Pin , Db4 = Portd.4 , Db5 = Portd.5 , Db6 = Portd.6 , Db7 = Portd.7 , E = Portd.2 , Rs = Portd.0
Config Lcd = 20 * 4                                         'configuro tipo de LCD
Cursor Off Noblink                                          'apago el cursor
Locate 4 , 1                                                'asigno posicion de muesteo
Lcd "*"                                                     'muestro en pantalla

Config Kbd = Portb                                          'asigno el puerto B para el uso de keypad

Dim V As Byte                                               'declaro variable "V" para leer el teclado
Dim Y As Byte : Y = 4                                       'declaro y le doy valor a la variable "Y"
Dim X As Byte : X = 1                                       'declaro y le doy valor a la variable "X"

'*******************************************************************************************************************

 '****************************BUCLE PRINCIPAL*********************************
Do

V = Getkbd()                                                'Leo el keypad

Select Case V                                               'Analizo los casos para V

Case 1:
 Cls                                                        'Limpio pantalla LCD
 Waitms 10                                                  'espero 10 milisegundos
 Y = Y - 1                                                  'decremento Y
If Y <= 1 Then                                              'pregunto si Y llego a su limite
Y = 1                                                       'reescribo su valor para no sobrepasar el limite
Cls                                                         'Limpio pantalla LCD
Waitms 400                                                  'espero 400 milisegundos
Locate 1 , X                                                'posiciono texto a mostrar
Lcd "*"                                                     'Muestro en pantalla
Else
Locate Y , X                                                'posiciono texto a mostrar
Lcd "*"                                                     'Muestro en pantalla
End If


Case 4:
 Cls                                                        'Limpio pantalla LCD
 Waitms 10                                                  'espero 10 milisegundos
 X = X - 1                                                  'decremento X
If X <= 1 Then                                              'pregunto si X llego a su limite
X = 1                                                       'reescribo su valor para no sobrepasar el limite
Cls                                                         'Limpio pantalla LCD
Waitms 400                                                  'espero 400 milisegundos
Locate Y , 1                                                'posiciono texto a mostrar
Lcd "*"                                                     'Muestro en pantalla
Else
Locate Y , X                                                'posiciono texto a mostrar
Lcd "*"                                                     'Muestro en pantalla
End If


Case 6:
 Cls                                                        'Limpio pantalla LCD
 Waitms 10                                                  'espero 10 milisegundos
 X = X + 1                                                  'Incremento X
If X >= 20 Then                                             'pregunto si X llego a su limite
X = 20                                                      'reescribo su valor para no sobrepasar el limite
Cls                                                         'Limpio pantalla LCD
Waitms 400                                                  'espero 400 milisegundos
Locate Y , 20                                               'posiciono texto a mostrar
Lcd "*"                                                     'Muestro en pantalla
Else
Locate Y , X                                                'posiciono texto a mostrar
Lcd "*"                                                     'Muestro en pantalla
End If


Case 9:
Cls                                                         'Limpio pantalla LCD
Waitms 10                                                   'espero 10 milisegundos
 Y = Y + 1                                                  'Incremento Y
If Y >= 4 Then                                              'pregunto si Y llego a su limite
Y = 4                                                       'reescribo su valor para no sobrepasar el limite
Cls                                                         'Limpio pantalla LCD
 Waitms 400                                                 'espero 400 milisegundos
Locate 4 , X                                                'posiciono texto a mostrar
Lcd "*"                                                     'Muestro en pantalla
Else
Locate Y , X                                                'posiciono texto a mostrar
Lcd "*"                                                     'Muestro en pantalla
End If

End Select

Loop

'**************************************************************************
