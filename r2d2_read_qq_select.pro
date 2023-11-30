function r2d2_read_qq_select,xs,n,p

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
     if jr0 eq p.jr[np0] then begin
        qql = fltarr(p.iixl[np0],p.jjxl[np0],p.kx,p.mtype)
        prl = fltarr(p.iixl[np0],p.jjxl[np0],p.kx)
        tel = fltarr(p.iixl[np0],p.jjxl[np0],p.kx)
        opl = fltarr(p.iixl[np0],p.jjxl[np0],p.kx)
        
        par_dir = string(np0/1000,form='(i5.5)')+'/'
        chi_dir = string(np0,form='(i8.8)')+'/'
        
        openr,unit,p.datadir+'remap/qq/'+par_dir+chi_dir+'qq.dac.'+string(n,form='(i8.8)')+'.'+string(np0,form='(i8.8)') $
              ,swap_if_little_endian=p.swap,/get_lun
        readu,unit,qql,prl,tel,opl
        free_lun,unit
        close,unit
      
        qq.ro[p.jss[np0]:p.jee[np0],*] = qql[i0-p.iss[np0],*,*,0]
        qq.vx[p.jss[np0]:p.jee[np0],*] = qql[i0-p.iss[np0],*,*,1]
        qq.vy[p.jss[np0]:p.jee[np0],*] = qql[i0-p.iss[np0],*,*,2]
        qq.vz[p.jss[np0]:p.jee[np0],*] = qql[i0-p.iss[np0],*,*,3]
        qq.bx[p.jss[np0]:p.jee[np0],*] = qql[i0-p.iss[np0],*,*,4]
        qq.by[p.jss[np0]:p.jee[np0],*] = qql[i0-p.iss[np0],*,*,5]
        qq.bz[p.jss[np0]:p.jee[np0],*] = qql[i0-p.iss[np0],*,*,6]
        qq.se[p.jss[np0]:p.jee[np0],*] = qql[i0-p.iss[np0],*,*,7]
        qq.pr[p.jss[np0]:p.jee[np0],*] = prl[i0-p.iss[np0],*,*]
        qq.te[p.jss[np0]:p.jee[np0],*] = tel[i0-p.iss[np0],*,*]
        qq.op[p.jss[np0]:p.jee[np0],*] = opl[i0-p.iss[np0],*,*]
     endif
  endfor

  return,qq
end
