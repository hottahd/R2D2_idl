if n_elements(caseid) eq 0 then begin
  print,'input caseid id (3 digit)'
  read,icaseid
  caseid='d'+string(icaseid,format='(i3.3)')
endif

datadir = '../run/'+caseid+'/data/'

p = r2d2_init(datadir)

window,0,xs = 800, ys = 750
!p.multi = [0,2,2]
!p.charsize = 1.5

for n = p.nd-1,p.nd-1 do begin
   print,n
   t = r2d2_read_time(n,p)
   qq2 = r2d2_read_qq_select(p.rsun-2.e8,n,p)
   qqi = r2d2_read_tau(n,p)
   vc = r2d2_read_vc(n,p)

   contour,qqi.in,p.y*1.e-8,p.z*1.e-8,min=0.5e10,max=5.e10,/fill,/xst,/yst $
           ,title='Emergent intensity',ytitle='Mm',nlevels=200
   contour,qq2.vx,p.y*1.e-8,p.z*1.e-8,min=-5.e5,max=5.e5,/fill,/xst,/yst $
           ,title='vx at 2 Mm depth',nlevels=200
   contour,transpose((vc.sep-vc.sem)/vc.serms),p.z*1.e-8,(p.x-p.rsun)*1.e-8 $
           ,max=6.,min=-6.,/fill,/xst,/yst,nlevels=200 $
           ,title='(s1-<s1>)/srms',xtitle='Mm',ytitle='Mm'
   vxrms = sqrt(mean(vc.vxrms^2,dimension=2))
   vhrms = sqrt(mean(vc.vyrms^2 + vc.vzrms^2,dimension=2))
   plot,(p.x-p.rsun)*1.e-8,vhrms $
        ,title='RMS velocity'
   oplot,(p.x-p.rsun)*1.e-8,vxrms
endfor

end
