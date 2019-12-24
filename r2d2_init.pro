;; This script defines functions for initial reading of basic setup
function r2d2_init, dir

  p = create_struct('rsun',6.9598947e10)
  
  ;; read time step parameter
  nd = 1 & ni = 1
  openr,unit,dir+'param/nd.dac',/get_lun
  readf,unit,nd,ni
  close,unit

  p = create_struct(p,'nd',nd,'ni',ni)
  
  tmp = ''

  ;; read basic parameters
  openr,unit,dir+'param/params.dac',/get_lun
  readf,unit,tmp
  tmp0 = strsplit(tmp,/extract)
  while not eof(unit) do begin
     readf,unit,tmp
     tmp0 = strsplit(tmp,/extract)

     if tmp0[2] eq 'i' then p = create_struct(p,tmp0[1],long64(tmp0[0]))
     if tmp0[2] eq 'd' then p = create_struct(p,tmp0[1],double(tmp0[0]))
     
  endwhile
  free_lun,unit
  close,unit

  p = create_struct(p,'ix',p.nx*p.ix0)
  p = create_struct(p,'jx',p.ny*p.jx0)
  p = create_struct(p,'kx',p.nz*p.kx0)

  ixg = p.ix + 2*p.margin
  jxg = p.jx + 2*p.margin
  kxg = p.kx + 2*p.margin
  
  x = dblarr(ixg) & y = dblarr(jxg) & z = dblarr(kxg)
  pr0 = dblarr(ixg) & te0 = dblarr(ixg) & ro0 = dblarr(ixg)
  se0 = dblarr(ixg) & en0 = dblarr(ixg) & op0 = dblarr(ixg) & tu0 = dblarr(ixg)
  dsedr0 = dblarr(ixg) & dtedr0 = dblarr(ixg)
  dprdro = dblarr(ixg) & dprdse = dblarr(ixg)
  dtedro = dblarr(ixg) & dtedse = dblarr(ixg)
  dendro = dblarr(ixg) & dendse = dblarr(ixg)
  gx = dblarr(ixg) & kp = dblarr(ixg) & cp = dblarr(ixg)
  fa = dblarr(ixg) & sa = dblarr(ixg) & xi = dblarr(ixg)
  
  openr,unit,dir+'back.dac',/f77_unformatted,swap_if_little_endian=p.swap,/get_lun
  readu,unit,x,y,z,pr0,te0,ro0,se0,en0,op0,tu0 $
        ,dsedr0,dtedr0,dprdro,dprdse,dtedro,dtedse,dendro,dendse $
        ,gx,kp,cp,fa,sa,xi
  free_lun,unit
  close,unit

  p = create_struct(p,'x',x[p.margin:ixg-p.margin-1])
  p = create_struct(p,'y',y[p.margin:jxg-p.margin-1])
  p = create_struct(p,'z',z[p.margin:kxg-p.margin-1])

  p = create_struct(p,'pr0',pr0[p.margin:ixg-p.margin-1]) ;; pressure
  p = create_struct(p,'te0',te0[p.margin:ixg-p.margin-1]) ;; temperature
  p = create_struct(p,'ro0',ro0[p.margin:ixg-p.margin-1]) ;; density
  p = create_struct(p,'se0',se0[p.margin:ixg-p.margin-1]) ;; entropy
  p = create_struct(p,'en0',en0[p.margin:ixg-p.margin-1]) ;; internal energy
  p = create_struct(p,'op0',op0[p.margin:ixg-p.margin-1]) ;; opacity
  p = create_struct(p,'tu0',tu0[p.margin:ixg-p.margin-1]) ;; optical depth
  p = create_struct(p,'dsedr0',dsedr0[p.margin:ixg-p.margin-1]) ;; entropy gradient
  p = create_struct(p,'dtedr0',dtedr0[p.margin:ixg-p.margin-1]) ;; temperature gradient
  p = create_struct(p,'dprdro',dprdro[p.margin:ixg-p.margin-1])
  p = create_struct(p,'dprdse',dprdse[p.margin:ixg-p.margin-1])
  p = create_struct(p,'dtedro',dtedro[p.margin:ixg-p.margin-1])
  p = create_struct(p,'dtedse',dtedse[p.margin:ixg-p.margin-1])
  p = create_struct(p,'dendro',dendro[p.margin:ixg-p.margin-1])
  p = create_struct(p,'dendse',dendse[p.margin:ixg-p.margin-1])
  p = create_struct(p,'gx',gx[p.margin:ixg-p.margin-1])
  p = create_struct(p,'kp',kp[p.margin:ixg-p.margin-1])
  p = create_struct(p,'cp',cp[p.margin:ixg-p.margin-1])
  p = create_struct(p,'fa',fa[p.margin:ixg-p.margin-1])
  p = create_struct(p,'sa',sa[p.margin:ixg-p.margin-1])
  p = create_struct(p,'xi',xi[p.margin:ixg-p.margin-1]) ;; RSST factor

  ;; read vc related information
  openr,unit,dir+'remap/c.dac',/get_lun

  itmp = 1
  readf,unit,itmp
  p = create_struct(p,'m2da',itmp) ;; number of vc
  p = create_struct(p,'cl',strarr(itmp)) ;; number of vc
  
  tmp = ''
  for m = 0,itmp-1 do begin
     readf,unit,tmp
     p.cl[m] = strcompress(tmp,/remove_all)
  endfor
  free_lun,unit
  close,unit
     
  ;; read mpi infromation
  iss = lonarr(p.npe) & iee = lonarr(p.npe)
  jss = lonarr(p.npe) & jee = lonarr(p.npe)
  iixl = lonarr(p.npe) & jjxl = lonarr(p.npe)
  np_ijr = lonarr(p.ixr,p.jxr)
  ir = lonarr(p.npe) & jr = lonarr(p.npe)
  i2ir = lonarr(ixg) & j2jr = lonarr(jxg)
  
  openr,unit,dir+'remap/remap_info.dac',swap_if_little_endian=p.swap,/get_lun
  readu,unit,iss,iee,jss,jee,iixl,jjxl,np_ijr,ir,jr,i2ir,j2jr
  free_lun,unit
  close,unit
  
  p = create_struct(p,'iss',iss-1)
  p = create_struct(p,'iee',iee-1)
  p = create_struct(p,'jss',jss-1)
  p = create_struct(p,'jee',jee-1)
  p = create_struct(p,'iixl',iixl)
  p = create_struct(p,'jjxl',jjxl)
  p = create_struct(p,'np_ijr',np_ijr)
  p = create_struct(p,'ir',ir)
  p = create_struct(p,'jr',jr)
  p = create_struct(p,'i2ir',i2ir[p.margin:ixg-p.margin-1])
  p = create_struct(p,'j2jr',j2jr[p.margin:jxg-p.margin-1])
  
  return,p
end
