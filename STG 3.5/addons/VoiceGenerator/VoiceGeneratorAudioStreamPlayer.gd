extends AudioStreamPlayer

signal finished_phrase

var _phrase: String = ""
var _phrase_pos: int = 0
var _phrase_wait: float = -1

var _original_pitch_scale: float
var _punctuations: Dictionary = {
	" ": 0.1,
	",": 0.2,
	".": 0.2,
	"!": 0.2,
	"?": 0.2,
}

func _process(delta: float) -> void:
	_phrase_wait -= delta
	
	if not _phrase or _phrase_wait > 0:
		return
	
	if not playing:
		if _phrase_pos < _phrase.length():
			if _punctuations.has(_phrase[_phrase_pos]):
				if _original_pitch_scale:
					pitch_scale = _original_pitch_scale
					_original_pitch_scale = 0
				_phrase_wait = _punctuations[_phrase[_phrase_pos]]
			else:
				var question_distance: int = get_distance_to_question(_phrase, _phrase_pos)
				if question_distance >= 0 and question_distance < 4:
					if not _original_pitch_scale:
						_original_pitch_scale = pitch_scale
					pitch_scale += 0.15 / float(question_distance)
				play()
			_phrase_pos += 1
		else:
			emit_signal("finished_phrase")
			_phrase = ""

func get_distance_to_question(text: String, from_pos: int):
	var closest_question_idx: int = -1
	var symbol_idx: int = from_pos + 1
	while symbol_idx < text.length():
		if text[symbol_idx] == "?":
			closest_question_idx = symbol_idx - _phrase_pos
			break
		symbol_idx += 1
	return closest_question_idx

func read(text: String) -> void:
	_phrase = text
	_phrase_pos = 0

func is_reading() -> bool:
	return !!_phrase

func is_waiting() -> bool:
	return _phrase_wait > 0
