'''
Uses the inner and outer rings of permutations as in
khlar's paper to generate all possible planning levels
each list's even members are linked by a permutation.
The outer and inner layouts digit ordering is top-left, top-right, bottom-right, bottom-left

The trial form is:
GAME_FILE = [nivel_inicial, perdidas, victorias, trial_count, [TRIAL, TRIAL, ..]]
TRIAL = [nivel, min_moves, max_moves, rotacion, tlh, trh, blh, brh, tlc, trc, blc, brc]
'''


outer = ['0123','3120','3102','3012','0312','2310',
         '2301','2031','0231','1230','1203','1023',]
inner = ['2103','2130','0132','1032','1302','1320',
         '0321','3021','3201','3210','0213','2013',]
        
def moves(orig, dest):
    def position(pos):
        try:
            return outer, outer.index(pos)
        except ValueError, e:
            return inner, inner.index(pos)
        
    g1, p1 = position(orig)
    g2, p2 = position(dest)

    if p1 == p2 and g1 != g2 and p1 % 2:
        return 3, 1 # special case, no bridge and the same location means 3 jumps

    half_ring = len(g1)/2
    raw_dist = abs(p1-p2)
    dist = (half_ring - raw_dist % half_ring) if (raw_dist > half_ring) else raw_dist #wrap around if that path is shorter

    if g1 == g2:
        rot = 1
    else:
	rot = 0
        dist += 1 # add one more move for permutation

    return dist, rot


def create_game_file(starting_level, losses, wins, trial_count):
    def chars(val): #position string as a house position list
        return [int(val[i]) for i in (0,1,3,2)] 
    
    def houses(val): #position string as a char position list
        return [(int(val[i]) if val[i]!='0' else 4) for i in (0,1,3,2)]
    
    all = outer + inner
    trials = []
    #i = 0
    for x in all:
        for y in all:
            if x == y: continue
            level,rot = moves(x,y)
            if level > 1:
                max_moves = 8 if level <= 4 else level*2
                #i += 1
                #trials.append([i, max_moves, level, rot] + houses(x) + chars(y))
                trials.append([level, max_moves, level, rot] + houses(x) + chars(y))

    return str( [starting_level, losses, wins, trial_count, trials] )
    
if __name__ == "__main__":
    import sys
    if len(sys.argv) != 6:
        print 'Usage: %s <GAME_FILE_NAME> <STARTING_LEVEL> <LOSSES> <WINS> <TRIAL_COUNT>' % sys.argv[0]
        sys.exit()
    
    game = create_game_file(*[int(x) for x in sys.argv[2:]])
    file(sys.argv[1],'w').write(game)
        
