'*************************************CONFIGURO EL MICRO********************************************************
$regfile = "m328pdef.dat"
$crystal = 16000000
$hwstack = 40
$swstack = 16
$framesize = 32
'**************************************************************************************************************

'********************************** CONFIGURACION DE PINES Y VARIABLES ****************************************
Config Portb = Output

Dim Dato As Byte

'**************************************************************************************************************


'****************************BUCLE PRINCIPAL*********************************

Do

  Dato = Waitkey() 'Creo instancia de comunicacion Bluetooth entre Arduino Uno y app

If Dato = "A" Then
Portb.0 = 1
Print "A"
End If

If Dato = "B" Then
Reset Portb.0
Print "B"
End If


Loop

'****************************************************************************




