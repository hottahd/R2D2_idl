close,/all
if n_elements(caseid) eq 0 then begin
  print,'input caseid id (3 digit)'
  read,icaseid
  caseid='d'+string(icaseid,format='(i3.3)')
endif

datadir = '../run/'+caseid+'/data/'

p = r2d2_init(datadir)

end
