function r2d2_read_time, n, p
  t = 0.d0
  openr,unit,p.datadir+'time/mhd/t.dac.'+string(n,form='(i8.8)'),swap_if_little_endian=p.swap,/get_lun
  readu,unit,t
  free_lun,unit
  close,unit
  
  return,t
end
