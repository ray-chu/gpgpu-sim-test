
# parsetab.py
# This file is automatically generated. Do not edit.
_tabversion = '3.2'

_lr_method = 'LALR'

_lr_signature = '\x05\xacZ\xb8\x00O\x7f\xb5\x89\xdb\x86\x0c\x92\xa5\xd8\x8a'
    
_lr_action_items = {'NUMBERSEQUENCE':([1,],[3,]),'$end':([2,3,],[0,-1,]),'FILENAME':([0,],[1,]),}

_lr_action = { }
for _k, _v in _lr_action_items.items():
   for _x,_y in zip(_v[0],_v[1]):
      if not _x in _lr_action:  _lr_action[_x] = { }
      _lr_action[_x][_k] = _y
del _lr_action_items

_lr_goto_items = {'sentence':([0,],[2,]),}

_lr_goto = { }
for _k, _v in _lr_goto_items.items():
   for _x,_y in zip(_v[0],_v[1]):
       if not _x in _lr_goto: _lr_goto[_x] = { }
       _lr_goto[_x][_k] = _y
del _lr_goto_items
_lr_productions = [
  ("S' -> sentence","S'",1,None,None,None),
  ('sentence -> FILENAME NUMBERSEQUENCE','sentence',2,'p_sentence','/Downloads/gpgpu-sim/v3.x/aerialvision/lexyacctexteditor.py',101),
]
