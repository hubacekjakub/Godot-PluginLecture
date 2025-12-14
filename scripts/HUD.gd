extends CanvasLayer

func _ready():
	# Connect to signals
	PlayerState.health_changed.connect(_on_health_changed)
	PlayerState.books_changed.connect(_on_books_changed)
	
	# Initialize values
	_on_health_changed(PlayerState.health)
	_on_books_changed(PlayerState.books)

func _on_health_changed(value):
	$ProgressBar.value = value

func _on_books_changed(value):
	$Label.text = "Books: " + str(value)
