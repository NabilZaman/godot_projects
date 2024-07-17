# This is a double-ended queue implementation in GDScript

class_name Deque
extends RefCounted

######
#
# _front:  middle of deque -> [ _, _, _, _, _] <- _front of deque
# _back:  middle of deque -> [ _, _, _, _, _] <- _back of deque
#
# When balanced: 0 <= len(_front) - len(_back) <= 1
#
# When there are an odd number of elements, the extra element is placed in the "_front" array
#

var _front: Array = []
var _back: Array = []
var _size: int = 0

func size():
    return _size

func _rebalance():
    var size_diff = _front.size() - _back.size()
    # we have a tolerance of at most 1, biasing towards the _front
    if size_diff == 0 or size_diff == 1:
        return
    
    var new_front = []
    var new_back = []
    # half the elements go in the _back, rounded down
    var target_elements_in_back = _size / 2
    # the rest go in the _front
    var target_elements_in_front = _size - target_elements_in_back
    var excess_elements_in_front = _front.size() - target_elements_in_front
    var excess_elements_in_back = _back.size() - target_elements_in_back
    
    # first copy any excess elements in the _back, into the new _front, looping backwards
    for i in range(excess_elements_in_back - 1,  -1, -1):
        new_front.append(_back[i])
    # next, copy any excess elements in the _front, into the new _back, looping backwards
    for i in range(excess_elements_in_front - 1,  -1, -1):
        new_back.append(_front[i])
    # then, copy the rest of the old _front into the new _front
    for i in range(max(excess_elements_in_front, 0),  _front.size()):
        new_front.append(_front[i])
    # finally, copy the rest of the old _back into the new _back
    for i in range(max(excess_elements_in_back, 0),  _back.size()):
        new_back.append(_back[i])
    self._front = new_front
    self._back = new_back
        

func peek_front():
    if _size == 0:
        return null
    if _front.size() == 0:
        return _back[0]
    return _front[-1]

func peek_back():
    if _size == 0:
        return null
    if _back.size() == 0:
        return _front[0]
    return _back[-1]

func pop_front():
    if _size == 0:
        return null
    self._size -= 1
    if _front.size() == 0:
        _rebalance()
    return _front.pop_back()

func pop_back():
    if _size == 0:
        return null
    self._size -= 1
    if _back.size() == 0:
        _rebalance()
    # if the _back is still empty, there must be only one element, and it's in the _front
    if _back.size() == 0:
        return _front.pop_back()
    return _back.pop_back()

func push_front(elem):
    _front.append(elem)
    self._size += 1

func push_back(elem):
    _back.append(elem)
    self._size += 1

func append(elem):
    push_back(elem)

func is_empty() -> bool:
    return _size == 0

func from_array(arr: Array) -> Deque:
    var deque := Deque.new()
    deque._front = arr
    deque._rebalance()
    return deque
    
func _init():
    pass
