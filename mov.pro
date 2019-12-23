if n_elements(caseid) eq 0 then begin
  print,'input caseid id (3 digit)'
  read,icaseid
  caseid='d'+string(icaseid,format='(i3.3)')
endif

dir = '../run/'+caseid+'/data/'

p = r2d2_read_init(dir)

window,0,xs = 800, ys = 800
!p.multi = [0,2,2]
!p.charsize = 1.5

for n = 0,p.nd-1 do begin
   t = r2d2_read_time(dir,n,p)
   qq2 = r2d2_read_qq_select(dir,2.e8,n,p)
   qqi = r2d2_read_tau(dir,n,p)
   vc = r2d2_read_vc(dir,n,p)

   contour,qqi.in,p.y*1.e-8,p.z*1.e-8,min=1.e10,max=3.e10,/fill,/xst,/yst
   contour,qq2.vx,p.y*1.e-8,p.z*1.e-8,min=-3.e5,max=3.e5,/fill,/xst,/yst
   contour,transpose(vc.tep),p.x-p.rsun,p.z,/fill,/xst,/yst
   contour,qqi.vx,p.y,p.z,/fill,/xst,/yst
endfor

end
