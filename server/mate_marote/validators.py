class GameValidationError(Exception): pass

def int_gte(val, where, gte_than=0):
    if val < gte_than or val % 1:
        raise GameValidationError('%s: debe ser un entero mayor o igual a %s y es %s' % (where, gte_than, val))

def belongs(val, group, where):
    if val not in group:
        params = (where, ','.join(str(i) for i in group), val)
        raise GameValidationError("%s: debe ser alguno de los siguientes valores:%s . Es %s]" % params)

def validate_memory_game(gamefile):
    '''
    GAME_FILE = [nivel_inicial, perdidas, victorias, numero_de_trials, [TRIAL, TRIAL,...]]
    TRIAL = [nivel, agrupacion, [FICHA, FICHA,...]]
    FICHA = [marco, fondo, sombrilla, baldes, estrellas, personaje, lentes]
    '''
    try:
        gamedata = eval(gamefile)
    except Exception, e:
        raise GameValidationError('Error de sintaxis, archivo mal formado, en la linea:%s, caracter:%s' % (e.lineno, e.offset) )

    nivel = gamedata[0]
    niveles = set(x[0] for x in gamedata[4])
    if gamedata[0] not in niveles:
        raise GameValidationError("El nivel inicial es %s pero no hay trials de ese nivel" % nivel)

    int_gte(gamedata[1], 'perdidas')
    int_gte(gamedata[2], 'victorias')
    int_gte(gamedata[3], 'numero_de_trials', 1)
    
    trials = gamedata[4]
    if not trials:
        raise GameValidationError('El archivo no tiene trials!')
    
    for i,trial in enumerate(trials):
        validate_memory_trial(i, trial)
        
def validate_memory_trial(trial_id, trial):
    int_gte(trial[0], 'Nivel de trial %s' % trial_id)
    belongs(trial[1], range(8), 'Agrupacion del trial %s' % trial_id)
    for i,card in enumerate(trial[2]):
        validate_memory_card(i, trial_id, card)
        
def validate_memory_card(card_id, trial_id, card):
    where = 'Ficha %s del Trial %s' % (card_id,trial_id,)
    if len(card) != 7:
        raise GameValidationError('%s: La cantidad de elementos deberia ser 7, y son %s' % (where, len(card)))
    
    layers = [('marco', range(1,13)),
              ('fondo', range(1,14)),
              ('sombrilla', range(13)),
              ('baldes', range(3)),
              ('estrellas', range(11)),
              ('personaje', range(4)),
              ('lentes', range(2)),]
    
    for i,(name,group) in enumerate(layers):
        where = '%s de ficha %s del Trial %s' % (name, card_id, trial_id,)
        belongs(card[i], group, where)

        