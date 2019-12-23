function r2d2_read_qq_select, dir,xs,n,p

  qq = create_struct('ro',fltarr(p.jx,p.kx))
  qq = create_struct('vx',fltarr(p.jx,p.kx),qq)
  qq = create_struct('vy',fltarr(p.jx,p.kx),qq)
  qq = create_struct('vz',fltarr(p.jx,p.kx),qq)
  qq = create_struct('bx',fltarr(p.jx,p.kx),qq)
  qq = create_struct('by',fltarr(p.jx,p.kx),qq)
  qq = create_struct('bz',fltarr(p.jx,p.kx),qq)
  qq = create_struct('se',fltarr(p.jx,p.kx),qq)
  qq = create_struct('pr',fltarr(p.jx,p.kx),qq)
  qq = create_struct('te',fltarr(p.jx,p.kx),qq)
  qq = create_struct('op',fltarr(p.jx,p.kx),qq)
  
  a = min(abs(p.x-xs),i0)
  ir0 = p.i2ir[i0]
     
  for jr0 = 1,p.jxr do begin  
     np0 = p.np_ijr[ir0-1,jr0-1]
     qql = fltarr(p.mtype,p.iixl[np0],p.jjxl[np0],p.kx)
     prl = fltarr(p.iixl[np0],p.jjxl[np0],p.kx)
     tel = fltarr(p.iixl[np0],p.jjxl[np0],p.kx)
     opl = fltarr(p.iixl[np0],p.jjxl[np0],p.kx)
       
     openr,unit,dir+'remap/qq.dac.'+string(n,form='(i8.8)')+'.'+string(np0,form='(i8.8)') $
           ,swap_if_little_endian=p.swap,/get_lun
     readu,unit,qql,prl,tel,opl
     free_lun,unit
     close,unit
        
     qq.ro[p.jss[np0]:p.jee[np0],*] = qql[0,i0-p.iss[np0],*,*]
     qq.vx[p.jss[np0]:p.jee[np0],*] = qql[1,i0-p.iss[np0],*,*]
     qq.vy[p.jss[np0]:p.jee[np0],*] = qql[2,i0-p.iss[np0],*,*]
     qq.vz[p.jss[np0]:p.jee[np0],*] = qql[3,i0-p.iss[np0],*,*]
     qq.bx[p.jss[np0]:p.jee[np0],*] = qql[4,i0-p.iss[np0],*,*]
     qq.by[p.jss[np0]:p.jee[np0],*] = qql[5,i0-p.iss[np0],*,*]
     qq.bz[p.jss[np0]:p.jee[np0],*] = qql[6,i0-p.iss[np0],*,*]
     qq.se[p.jss[np0]:p.jee[np0],*] = qql[7,i0-p.iss[np0],*,*]
     qq.pr[p.jss[np0]:p.jee[np0],*] = prl[i0-p.iss[np0],*,*]
     qq.te[p.jss[np0]:p.jee[np0],*] = tel[i0-p.iss[np0],*,*]
     qq.op[p.jss[np0]:p.jee[np0],*] = opl[i0-p.iss[np0],*,*]
  endfor

  return,qq
end
