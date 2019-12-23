function r2d2_read_vc, dir, n, p

  vc0 = fltarr(p.m2da,p.ix,p.jx)
  
  openr,unit,dir+'remap/vla.dac.'+string(n,form='(i8.8)') $
        ,swap_if_little_endian=p.swap,/get_lun
  readu,unit,vc0
  free_lun,unit
  close,unit

  vc = create_struct(p.cl[0],vc0[0,*])

  for m = 1,p.m2da-1 do begin
     if m ne 26 then begin
        if not (m ge 85) and (m le 93) then begin        
           print,p.cl[m],m
           vc = create_struct(p.cl[m],vc0[m,*],vc)
        endif
     endif
  endfor
  
  return,vc
end
        
  
