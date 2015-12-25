#!/bin/bash 

r=0
tests=1
runtimeSuccess[0]="success"
echo $runtimeSuccess
if (( $r%$tests == 0 )) && (( "${runtimeSuccess[$r]}" == 'success' ));
#if(($r%$test == 0))
then
   echo 'hello'

else

   echo $r

fi


