wire_inv = ['~', '']
inc = 31

for a in wire_inv:
    for b in wire_inv:
        for c in wire_inv:
            for d in wire_inv:
                for e in wire_inv:
                    print("(in[{5}] & {0}s[4] & {1}s[3] & {2}s[2] & {3}s[1] & {4}s[0])".format(a,b,c,d,e, inc))
                    inc -= 1