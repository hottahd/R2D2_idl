function r2d2_read_qq, n,p

  qq = create_struct('ro',fltarr(p.ix,p.jx,p.kx))
  qq = create_struct('vx',fltarr(p.ix,p.jx,p.kx),qq)
  qq = create_struct('vy',fltarr(p.ix,p.jx,p.kx),qq)
  qq = create_struct('vz',fltarr(p.ix,p.jx,p.kx),qq)
  qq = create_struct('bx',fltarr(p.ix,p.jx,p.kx),qq)
  qq = create_struct('by',fltarr(p.ix,p.jx,p.kx),qq)
  qq = create_struct('bz',fltarr(p.ix,p.jx,p.kx),qq)
  qq = create_struct('se',fltarr(p.ix,p.jx,p.kx),qq)
  qq = create_struct('pr',fltarr(p.ix,p.jx,p.kx),qq)
  qq = create_struct('te',fltarr(p.ix,p.jx,p.kx),qq)
  qq = create_struct('op',fltarr(p.ix,p.jx,p.kx),qq)

  for ir0 = 1,p.ixr do begin
     for jr0 = 1,p.jxr do begin
         np0 = p.np_ijr[ir0-1,jr0-1]
         if ir0 eq p.ir[np0] and jr0 eq p.jr[np0] then begin
            qql = fltarr(p.iixl[np0],p.jjxl[np0],p.kx,p.mtype)
            prl = fltarr(p.iixl[np0],p.jjxl[np0],p.kx)
            tel = fltarr(p.iixl[np0],p.jjxl[np0],p.kx)
            opl = fltarr(p.iixl[np0],p.jjxl[np0],p.kx)

            ;番号分のディレクトリを定義
            par_dir = string(np0/1000,form='(i5.5)')+'/'
            chi_dir = string(np0,form='(i8.8)')+'/'

            openr,unit,p.datadir+'remap/qq/'+par_dir+chi_dir+'qq.dac.'+string(n,form='(i8.8)')+'.'+string(np0,form='(i8.8)') $
                  ,swap_if_little_endian=swap,/get_lun
            readu,unit,qql,prl,tel,opl
            free_lun,unit
            close,unit

            qq.ro[p.iss[np0]:p.iee[np0],p.jss[np0]:p.jee[np0],*] = qql[*,*,*,0]
            qq.vx[p.iss[np0]:p.iee[np0],p.jss[np0]:p.jee[np0],*] = qql[*,*,*,1]
            qq.vy[p.iss[np0]:p.iee[np0],p.jss[np0]:p.jee[np0],*] = qql[*,*,*,2]
            qq.vz[p.iss[np0]:p.iee[np0],p.jss[np0]:p.jee[np0],*] = qql[*,*,*,3]
            qq.bx[p.iss[np0]:p.iee[np0],p.jss[np0]:p.jee[np0],*] = qql[*,*,*,4]
            qq.by[p.iss[np0]:p.iee[np0],p.jss[np0]:p.jee[np0],*] = qql[*,*,*,5]
            qq.bz[p.iss[np0]:p.iee[np0],p.jss[np0]:p.jee[np0],*] = qql[*,*,*,6]
            qq.se[p.iss[np0]:p.iee[np0],p.jss[np0]:p.jee[np0],*] = qql[*,*,*,7]
            qq.pr[p.iss[np0]:p.iee[np0],p.jss[np0]:p.jee[np0],*] = prl
            qq.te[p.iss[np0]:p.iee[np0],p.jss[np0]:p.jee[np0],*] = tel
            qq.op[p.iss[np0]:p.iee[np0],p.jss[np0]:p.jee[np0],*] = opl
         endif
     endfor
  endfor

  return,qq
end
