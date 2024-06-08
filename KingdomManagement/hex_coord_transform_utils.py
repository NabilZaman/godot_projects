def transf(x, y):
  offx = x - 13
  offy = y - 17
  xres = offx * 2 - (offy % 2)
  yres = offy
  return (xres, yres)

r = lambda xmin, xmax, y: [transf(x, y) for x in range(xmin, xmax+1)]
flatten = lambda ls: [x for l in ls for x in l]

def gen_rows(rows):
  for c in flatten(rows):
    print(form.format(c[0], c[1]))

print("Hello... ;)")

import time
time.sleep(2)
