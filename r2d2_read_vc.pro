function r2d2_read_vc, n, p

  vc0 = fltarr(p.ix,p.jx,p.m2da)
  
  openr,unit,p.datadir+'remap/vl/vla.dac.'+string(n,form='(i8.8)') $
        ,swap_if_little_endian=p.swap,/get_lun
  readu,unit,vc0
  free_lun,unit
  close,unit

  vc = create_struct(p.cl[0],reform(vc0[*,*,0]))

  for m = 1,p.m2da-1 do begin
     vc = create_struct(p.cl[m],reform(vc0[*,*,m]),vc)
  endfor
  
  return,vc
end
