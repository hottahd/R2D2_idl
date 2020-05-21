datadir='../run/d025/data/tau1/'


x = dblarr(1024)
openr,unit,datadir+'x.dac',/get_lun
readu,unit,x
free_lun,unit
close,unit

qq = fltarr(1024,1024,7)
for n = 0,0 do begin
   openr,unit,datadir+'data'+string(n,form='(i8.8)')+'.dac',/get_lun
   readu,unit,qq
   free_lun,unit
   close,unit
endfor

end
  
