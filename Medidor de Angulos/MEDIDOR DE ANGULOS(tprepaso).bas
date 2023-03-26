'*************************************CONFIGURO EL MICRO********************************************************
$regfile = "m328pdef.dat"
$crystal = 16000000
$hwstack = 40
$swstack = 16
$framesize = 32
'**************************************************************************************************************

'*****************************CONFIGURACION DE PINES Y VARIABLES*****************************************************
Config Adc = Single , Prescaler = Auto                      'activo ADC para su uso
Bae Alias Pinc.1                                            'asigno boton de encendido/apagado en puerto C1
Bm Alias Pinc.2                                             'asigno boton de retencion de medida en puerto C2

Config Portb = Output                                       'configuro puerto B del micro como salida
Config Portd = Output                                       'configuro puerto D del micro como salida

Tu Alias Portd.0                                            'asigno el transistor de unidad en puerto D0
Td Alias Portd.1                                            'asigno el transistor de decena en puerto D1
Tc Alias Portd.2                                            'asigno el transistor de centena en puerto D2
R Alias Portd.3                                             'configuro reset en puerto D3

Dim Lectura As Word                                         'declaro la lectura en tipo word
 Dim Va As Bit                                              'declaro valor de estado como bit
 Va = 0
 Dim U1 As Byte                                             'declaro la unidad1 tipo byte
Dim U2 As Byte                                              'declaro la unidad2 tipo byte
Dim D1 As Byte                                              'declaro la decena1 tipo byte
Dim D2 As Byte                                              'declaro la decena2 tipo byte
Dim Cent As Byte                                            'declaro la centena tipo byte
Dim Cont As Byte                                            'declaro contador tipo byte
Dim Al As Word                                              'declaro angulo limite tipo word
Al = 0

Declare Sub Cuentas                                         'ingreso subrutina de calculos
Declare Sub Mostrar                                         'ingreso subrutina de muestreo de digitos
'*************************************************************************************************************

'*************************BUCLE PRINCIPAL******************************
Do

Lectura = Getadc(0)

If Lectura <= 532 Then                                      'si la lectura de angulos supera el limite seguira mostrando el mismo
Al = Lectura / 3.4
   Else
Al = 180
   Call Cuentas
   Call Mostrar                                             'en caso de no haber superado el limite seguira leyendo datos
 End If

    Call Cuentas                                            'llamo a la subrutina
   Call Mostrar                                             'llamo a la subrutina
  Gosub Ea                                                  'me dirijo a la funcion ea(encendido/apagado)
 Gosub Rm                                                   'me dirijo a la funcion rm (retencion de medida)

 Loop
'*******************************************************************

'*************SECUENCIA DE ENCENDIDO/APAGADO**************
 Ea:                                                        'encendido/apagado
If Bae = 1 Then                                             'pregunto si presione el boton
Waitms 10
If Bae = 1 Then                                             'confirmo si esta presionado
If R = 0 Then                                               'pregunto por el estado del reset
 R = 1                                                      'en caso de que reset sea 0 los displays seguiran encendidos
Else
R = 0                                                       'si el estado de la variable cambio apago los displays
  End If
  End If
  End If
 Return
'********************************************************

'*************SECUENCIA DE RETENCION DE ANGULOS**************
 Rm:                                                        'retencion de medida
If Bm = 1 Then                                              'pregunto si presione el boton
While Bm = 1                                                'mientras el boton este presionado no hara ninguna accion
Wend
If Va = 0 Then                                              'pregunto por el estado de la variable
While Va = 0                                                'mientras la variable sea 0 se mostrara el dato leido por el adc
Call Cuentas
Call Mostrar
If Bm = 1 Then                                              'pregunto si presione el boton
While Bm = 1                                                'mientras el boton este presionado no hara ninguna accion
Wend
Va = 1                                                      'pongo la variable en estado alto
End If
Wend
End If
End If
Va = 0                                                      'pongo la variable en estado bajo (para volver a variar)
 Return
 '*************************************************************

'*****************SUBRUTINA DE CALCULOS************************
 Sub Cuentas

Cent = Al / 100
D1 = Al Mod 100
D2 = D1 / 10
U2 = D1 Mod 10

End Sub
'************************************************************

'***********SUBRUTINA DE MUESTREO DE DIGITOS*****************

Sub Mostrar

   If Cont < 3 Then                                         'pregunto por la cantidad del contador(en este caso por la cantidad de displays son 3)
   Cont = Cont + 1                                          'si se cumple la condicion se icrementa el conteo
   Else
      Cont = 1                                              'en caso de que no se cumpla la condicion se regresara su valor a 1 para seguir contando
   End If

     If Cont = 1 Then                                       'si el contador es igual a 1 se activara el transistor de centena para mostrar su respectivo digito
      Tu = 0
      Td = 0
      Tc = 1
      Portb = Cent
      Waitms 8
       End If

      If Cont = 2 Then                                      'si el contador es igual a 2 se activara el transistor de decena para mostrar su respectivo digito
      Tu = 0
      Td = 1
      Tc = 0
      Portb = D2
      Waitms 8
      End If
      If Cont = 3 Then                                      'si el contador es igual a 3 se activara el transistor de unidad para mostrar su respectivo digito
      Tu = 1
      Td = 0
      Tc = 0
      Portb = U2
      Waitms 8
      End If

End Sub
'***********************************************************
