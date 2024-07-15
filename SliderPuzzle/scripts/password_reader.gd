class_name PasswordReader
extends TextReader

var password: String
var password_buffer: Array[String] = []

var password_len: int

signal password_match()

func check_password() -> void:
    if "".join(password_buffer) == password:
        password_match.emit()
        print("password matches!")

func handle_char(_char: String) -> void:
    password_buffer.append(_char)
    if len(password_buffer) > password_len:
        self.password_buffer = password_buffer.slice(-password_len)
    print("Buffer is %s" % "".join(password_buffer))
    if len(password_buffer) == password_len:
        check_password()

func _ready() -> void:
    self.character_pressed.connect(handle_char)

# NOTE: Only supports lower-case passwords
func _init(password: String) -> void:
    self.password = password.to_lower()
    self.password_len = len(password)

