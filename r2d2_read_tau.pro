function r2d2_read_tau, n,p

  qq = create_struct('in',fltarr(p.jx,p.kx))
  qq = create_struct('ro',fltarr(p.jx,p.kx),qq)
  qq = create_struct('se',fltarr(p.jx,p.kx),qq)
  qq = create_struct('pr',fltarr(p.jx,p.kx),qq)
  qq = create_struct('te',fltarr(p.jx,p.kx),qq)
  qq = create_struct('vx',fltarr(p.jx,p.kx),qq)
  qq = create_struct('vy',fltarr(p.jx,p.kx),qq)
  qq = create_struct('vz',fltarr(p.jx,p.kx),qq)
  qq = create_struct('bx',fltarr(p.jx,p.kx),qq)
  qq = create_struct('by',fltarr(p.jx,p.kx),qq)
  qq = create_struct('bz',fltarr(p.jx,p.kx),qq)
  qq = create_struct('he',fltarr(p.jx,p.kx),qq)

  qq = create_struct('ro01',fltarr(p.jx,p.kx),qq)
  qq = create_struct('se01',fltarr(p.jx,p.kx),qq)
  qq = create_struct('pr01',fltarr(p.jx,p.kx),qq)
  qq = create_struct('te01',fltarr(p.jx,p.kx),qq)
  qq = create_struct('vx01',fltarr(p.jx,p.kx),qq)
  qq = create_struct('vy01',fltarr(p.jx,p.kx),qq)
  qq = create_struct('vz01',fltarr(p.jx,p.kx),qq)
  qq = create_struct('bx01',fltarr(p.jx,p.kx),qq)
  qq = create_struct('by01',fltarr(p.jx,p.kx),qq)
  qq = create_struct('bz01',fltarr(p.jx,p.kx),qq)
  qq = create_struct('he01',fltarr(p.jx,p.kx),qq)

  qq = create_struct('ro001',fltarr(p.jx,p.kx),qq)
  qq = create_struct('se001',fltarr(p.jx,p.kx),qq)
  qq = create_struct('pr001',fltarr(p.jx,p.kx),qq)
  qq = create_struct('te001',fltarr(p.jx,p.kx),qq)
  qq = create_struct('vx001',fltarr(p.jx,p.kx),qq)
  qq = create_struct('vy001',fltarr(p.jx,p.kx),qq)
  qq = create_struct('vz001',fltarr(p.jx,p.kx),qq)
  qq = create_struct('bx001',fltarr(p.jx,p.kx),qq)
  qq = create_struct('by001',fltarr(p.jx,p.kx),qq)
  qq = create_struct('bz001',fltarr(p.jx,p.kx),qq)
  qq = create_struct('he001',fltarr(p.jx,p.kx),qq)
  
  qq_in = fltarr(p.m_tu,p.m_in,p.jx,p.kx)
  
  openr,unit,p.datadir+'tau/qq.dac.'+string(n,form='(i8.8)') $
        ,swap_if_little_endian=p.swap,/get_lun
  readu,unit,qq_in
  free_lun,unit
  close,unit

  qq.in = qq_in[0,0,*,*]
  qq.ro = qq_in[0,1,*,*]
  qq.se = qq_in[0,2,*,*]
  qq.pr = qq_in[0,3,*,*]
  qq.te = qq_in[0,4,*,*]
  qq.vx = qq_in[0,5,*,*]
  qq.vy = qq_in[0,6,*,*]
  qq.vz = qq_in[0,7,*,*]
  qq.bx = qq_in[0,8,*,*]
  qq.by = qq_in[0,9,*,*]
  qq.bz = qq_in[0,10,*,*]
  qq.he = qq_in[0,11,*,*]

  qq.ro01 = qq_in[1,1,*,*]
  qq.se01 = qq_in[1,2,*,*]
  qq.pr01 = qq_in[1,3,*,*]
  qq.te01 = qq_in[1,4,*,*]
  qq.vx01 = qq_in[1,5,*,*]
  qq.vy01 = qq_in[1,6,*,*]
  qq.vz01 = qq_in[1,7,*,*]
  qq.bx01 = qq_in[1,8,*,*]
  qq.by01 = qq_in[1,9,*,*]
  qq.bz01 = qq_in[1,10,*,*]
  qq.he01 = qq_in[1,11,*,*]

  qq.ro001 = qq_in[2,1,*,*]
  qq.se001 = qq_in[2,2,*,*]
  qq.pr001 = qq_in[2,3,*,*]
  qq.te001 = qq_in[2,4,*,*]
  qq.vx001 = qq_in[2,5,*,*]
  qq.vy001 = qq_in[2,6,*,*]
  qq.vz001 = qq_in[2,7,*,*]
  qq.bx001 = qq_in[2,8,*,*]
  qq.by001 = qq_in[2,9,*,*]
  qq.bz001 = qq_in[2,10,*,*]
  qq.he001 = qq_in[2,11,*,*]
  
  return,qq
end
